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

    NSLog(@"owner keys: %@", [[_maintenanceBlocksByOwner keyEnumerator] allObjects]);

    
    maintenanceBlock(weaklyHeldOwner, self);
}

- (void)setFirstProp:(double)firstProp {
    if (_firstProp != firstProp) {
        _firstProp = firstProp;
        _firstProp = [self firstProp];
        [self callTheBlock];
    }
}

- (void)setSecondProp:(NSString *)secondProp {

    if (![_secondProp isEqual:secondProp]) {

        _secondProp = secondProp;
        _secondProp = [self secondProp];
        [self callTheBlock];
    }
}

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
