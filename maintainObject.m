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
    }

    NSLog(@"init object");

    return self;
}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, weaklyHeldOwner);
    NSLog(@"address %zd", _maintenanceBlocksByOwner);
    NSMutableArray *maintenanceBlocksForOwner = [_maintenanceBlocksByOwner objectForKey:weaklyHeldOwner];
    NSLog(@"man %@", maintenanceBlocksForOwner);
    if (!maintenanceBlocksForOwner) {
        maintenanceBlocksForOwner = [NSMutableArray array];
        [_maintenanceBlocksByOwner setObject:maintenanceBlocksForOwner forKey:weaklyHeldOwner];
    }
    NSLog(@"man2 %@", maintenanceBlocksForOwner);

//    __weak id weakSelf = self;
    [maintenanceBlocksForOwner addObject:maintenanceBlock];
    NSLog(@"man2 %@", maintenanceBlocksForOwner);

    
    maintenanceBlock(weaklyHeldOwner, self);
}

//- (void)setObjectValue:(id)objectValue {
//    
//    if (![_objectValue isEqual:objectValue]) {
//        _objectValue = objectValue;
//        objectValue = [self objectValue];
//        for (id owner in _maintenanceBlocksByOwner) {
//            for (void (^maintenanceBlock)(id owner, id objValue) in [_maintenanceBlocksByOwner objectForKey:owner]) {
//                maintenanceBlock(owner, objectValue);
//            }
//        }
//    }
//}
- (void)callTheBlock {
    NSLog(@"%s %@", __PRETTY_FUNCTION__, _maintenanceBlocksByOwner);

    for (id owner in _maintenanceBlocksByOwner) {
        
        for (void (^maintenanceBlock)(id owner, id model) in
             [_maintenanceBlocksByOwner objectForKey:owner]) {
            maintenanceBlock(owner, self);
        }
    }
}

@end
