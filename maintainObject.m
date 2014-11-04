//
//  maintainObject.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "maintainObject.h"
#import <objc/runtime.h> 

@interface maintainObject ()

@end

@implementation maintainObject

- (id)init {
    self = [super init];
    
    if (self) {
        _maintenanceBlocksByOwner = [NSMapTable weakToStrongObjectsMapTable];
        [self setupObservingWithKeys:[[self class] keysFromProperties]];

    }

    return self;
}

- (void)withValueChangeUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock {
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

- (void)callTheBlock {
    
    for (id owner in _maintenanceBlocksByOwner) {
        
        for (void (^maintenanceBlock)(id owner, id model) in
             [_maintenanceBlocksByOwner objectForKey:owner]) {
            maintenanceBlock(owner, self);
        }
    }
}

-(void)setupObservingWithKeys:(NSArray *)keys {
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addObserver:self forKeyPath:obj options:NSKeyValueObservingOptionNew context:NULL];
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if ([self respondsToSelector:@selector(callTheBlock)]) {
        [self performSelector:@selector(callTheBlock)];
    }
    
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
