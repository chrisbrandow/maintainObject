//
//  maintainObject.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "maintainObject.h"
#import <objc/runtime.h> 

@interface maintainObject () {
    NSMapTable *_maintenanceBlocksByOwner;
    NSMutableDictionary *_maintenanceBlocksByKey;
}

@end

@implementation maintainObject

- (id)init {
    self = [super init];
    
    if (self) {
        _maintenanceBlocksByOwner = [NSMapTable weakToStrongObjectsMapTable];
        _maintenanceBlocksByKey = [NSMutableDictionary new];
        [self setupObservingWithKeys:[[self class] keysFromProperties]];

    }

    return self;
}

- (void)whenPropertyChanges:(NSString *)propertyName updateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
    NSAssert([[[self class] keysFromProperties] containsObject:propertyName], @"oops, your key is not a property in this model");
    NSLog(@"has this in props: %zd, %@, %@",[[[self class] keysFromProperties] containsObject:propertyName], propertyName, [[self class] keysFromProperties]);
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

    //    NSLog(@"owner keys: %@", [[_maintenanceBlocksByOwner keyEnumerator] allObjects]);
    maintenanceBlock(weaklyHeldOwner, weakSelf);

}
- (void)withChangeInPropertiesUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
    [self withOwner:weaklyHeldOwner maintainWithModel:maintenanceBlock];
}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock {
    NSMutableArray *maintenanceBlocksForOwner = [_maintenanceBlocksByOwner objectForKey:weaklyHeldOwner];
    if (!maintenanceBlocksForOwner) {
        maintenanceBlocksForOwner = [NSMutableArray array];
        [_maintenanceBlocksByOwner setObject:maintenanceBlocksForOwner forKey:weaklyHeldOwner];
    }

    __weak id weakSelf = self;
    [maintenanceBlocksForOwner addObject:maintenanceBlock];

//    NSLog(@"owner keys: %@", [[_maintenanceBlocksByOwner keyEnumerator] allObjects]);
    maintenanceBlock(weaklyHeldOwner, weakSelf);
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

    if ([[_maintenanceBlocksByKey allKeys] containsObject:keyPath]) {
        //call the blocks by key
        [self callMaintenanceBlocksTable:[_maintenanceBlocksByKey objectForKey:keyPath]];
    }
    
    [self callMaintenanceBlocksTable:_maintenanceBlocksByOwner];
    
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
