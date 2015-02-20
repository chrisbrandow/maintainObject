//
//  maintainObject.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "binderObject.h"
#import <objc/runtime.h> 

@interface binderObject () {
    NSMapTable *_maintenanceBlocksByOwner;
    NSMutableDictionary *_maintenanceBlocksByKey;
}

@end

@implementation binderObject

- (id)init {
    self = [super init];
    NSLog(@"super class %@", [self.superclass class]);
    
    if (self) {
        _maintenanceBlocksByOwner = [NSMapTable weakToStrongObjectsMapTable];
        _maintenanceBlocksByKey = [NSMutableDictionary new];
        [self setupObservingWithKeys:[[self class] keysFromProperties]];
    }

    return self;
}

- (void)whenPropertyChanges:(NSString *)propertyName updateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
    NSAssert([[[self class] keysFromProperties] containsObject:propertyName], @"oops, your key is not a property in this model");
    [self whenPropertyChanges:propertyName internalUpdateObject:weaklyHeldOwner withBlock:maintenanceBlock];
}
- (void)bind:(id)boundObject toProperty:(NSString *)propertyName InBlock:(void (^)(id, id))maintenanceBlock {
    [self whenPropertyChanges:propertyName updateObject:boundObject withBlock:maintenanceBlock];
}
- (void)whenPropertyChanges:(NSString *)propertyName internalUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {

    NSMapTable *maintenanceBlocksByOwnerKey = [_maintenanceBlocksByKey objectForKey:propertyName]; //=
    
    if (!maintenanceBlocksByOwnerKey) {
        maintenanceBlocksByOwnerKey = [NSMapTable weakToStrongObjectsMapTable];
        [_maintenanceBlocksByKey setObject:maintenanceBlocksByOwnerKey forKey:propertyName];
    }
    
    NSMutableArray *maintenanceBlocksForOwner = [maintenanceBlocksByOwnerKey objectForKey:weaklyHeldOwner];
    if (!maintenanceBlocksForOwner) {
        maintenanceBlocksForOwner = [NSMutableArray array];
        [maintenanceBlocksByOwnerKey setObject:maintenanceBlocksForOwner forKey:weaklyHeldOwner];
    }
    
    __weak id weakSelf = self;
    [maintenanceBlocksForOwner addObject:maintenanceBlock];

    if ([propertyName containsString:@"Event"]) {
        return;
    }
    maintenanceBlock(weaklyHeldOwner, weakSelf);

}
- (void)withChangeInPropertiesUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
    [self withOwner:weaklyHeldOwner maintainWithModel:maintenanceBlock];
}

- (void)updateView:(UIView *)view withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
    NSAssert([[view class] isSubclassOfClass:[UIView class]], @"not a UIView class or subclass");
    [self withOwner:view maintainWithModel:maintenanceBlock];

}

- (void)whenProperty:(NSString *)propertyName startsOrStopsChanging:(valueChange)startOrStop updateBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
//- (void)property:(NSString *)propertyName onControlEvent:(UIControlEvents)event updateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
    __weak id weakSelf = self;

    propertyName = [propertyName stringByAppendingString:[NSString stringWithFormat:@"Event%zd",startOrStop]];
    [self whenPropertyChanges:propertyName internalUpdateObject:weakSelf withBlock:maintenanceBlock];

}

- (void)property:(NSString *)propertyName stopOrStartChanging:(valueChange)startOrStop {
//- (void)adjustProperty:(NSString *)propertyName onControlEvent:(UIControlEvents)event {

    propertyName = [propertyName stringByAppendingString:[NSString stringWithFormat:@"Event%zd", startOrStop]];
    
    if ([[_maintenanceBlocksByKey allKeys] containsObject:propertyName]) {
        //call the blocks by key
        [self callMaintenanceBlocksTable:[_maintenanceBlocksByKey objectForKey:propertyName]];
    }

}

- (void)stoppedChangingProperty:(NSString *)propertyName {
    propertyName = [propertyName stringByAppendingString:[NSString stringWithFormat:@"%zd", UIControlEventTouchUpInside]];

    if ([[_maintenanceBlocksByKey allKeys] containsObject:propertyName]) {
        //call the blocks by key
        [self callMaintenanceBlocksTable:[_maintenanceBlocksByKey objectForKey:propertyName]];
    }

}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock {
    NSMutableArray *maintenanceBlocksForOwner = [_maintenanceBlocksByOwner objectForKey:weaklyHeldOwner];
    if (!maintenanceBlocksForOwner) {
        maintenanceBlocksForOwner = [NSMutableArray array];
        [_maintenanceBlocksByOwner setObject:maintenanceBlocksForOwner forKey:weaklyHeldOwner];
    }

    [maintenanceBlocksForOwner addObject:maintenanceBlock];

}

-(void)setupObservingWithKeys:(NSArray *)keys {
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self addObserver:self forKeyPath:obj options:NSKeyValueObservingOptionNew context:NULL];
    }];
    
}

- (void)callMaintenanceBlocksTable:(NSMapTable *)blocksTable {

    for (id owner in blocksTable) {
        for (void (^maintenanceBlock)(id owner, id model) in
             [blocksTable objectForKey:owner]) {
            maintenanceBlock(owner, self);
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    BOOL callByKey = [[_maintenanceBlocksByKey allKeys] containsObject:keyPath];
    
    [self callMaintenanceBlocksTable:(callByKey) ? [_maintenanceBlocksByKey objectForKey:keyPath] : _maintenanceBlocksByOwner];

}

+ (NSArray *)keysFromProperties {
    
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList([self class], &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++) {
        [propertyArray addObject:@(property_getName(properties[i]))];
    }
    free(properties);
    
    return [NSArray arrayWithArray:propertyArray];
}

@end
