//
//  maintainObject.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "maintainObject.h"

@interface maintainObject ()

@end

@implementation maintainObject
@synthesize thirdObjectValue = _thirdObjectValue;
@synthesize objectValue = _objectValue;
@synthesize secondObjectValue = _secondObjectValue;

- (id)init {
    self = [super init];
    
    if (self) {
        _maintenanceBlocksByOwner = [NSMapTable weakToStrongObjectsMapTable];
        _thirdObjectValue = 55;
    }
    
    return self;
}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, maintainObject *model))maintenanceBlock {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSMutableArray *maintenanceBlocksForOwner = [_maintenanceBlocksByOwner objectForKey:weaklyHeldOwner];
    if (!maintenanceBlocksForOwner) {

        maintenanceBlocksForOwner = [NSMutableArray array];
        [_maintenanceBlocksByOwner setObject:maintenanceBlocksForOwner forKey:weaklyHeldOwner];
    }
    
    NSLog(@"baind bloc %@", maintenanceBlock);
    [maintenanceBlocksForOwner addObject:maintenanceBlock];
    NSLog(@"maintenace blocks count %zd", maintenanceBlocksForOwner.count);
    NSLog(@"maing count: %zd",_maintenanceBlocksByOwner);
    maintenanceBlock(weaklyHeldOwner, self);
}

-(double)objectValue {
    return _objectValue;
}

- (void)setModelObjectValue:(double)objectValue {
    NSLog(@"_obj %.1f, obj %.1f", _objectValue, objectValue);
    if (_objectValue != objectValue) {
        NSLog(@"one");
        _objectValue = objectValue;
        objectValue = [self objectValue];
        NSLog(@"maing count: %zd",_maintenanceBlocksByOwner);
        
        //could just abstract this part out., to avoid mistakes
        for (id owner in _maintenanceBlocksByOwner) {
            NSLog(@"two");

            for (void (^maintenanceBlock)(id owner, maintainObject *model) in
                 [_maintenanceBlocksByOwner objectForKey:owner]) {
                NSLog(@"three");

                maintenanceBlock(owner, self);
            }
        }
    }
}

-(id)secondObjectValue {
    return _secondObjectValue;
}

- (void)setModelSecondObjectValue:(NSString *)secondObjectValue {
    NSLog(@"_obj %@, obj %@", _secondObjectValue, secondObjectValue);
    if (![_secondObjectValue isEqual:secondObjectValue]) {
        NSLog(@"one");
        _secondObjectValue = secondObjectValue;
        secondObjectValue = [self secondObjectValue];
        NSLog(@"maing count: %zd",_maintenanceBlocksByOwner);
        for (id owner in _maintenanceBlocksByOwner) {
            NSLog(@"two");
            
            for (void (^maintenanceBlock)(id owner, maintainObject *model) in
                 [_maintenanceBlocksByOwner objectForKey:owner]) {
                NSLog(@"three");

                maintenanceBlock(owner, self);
            }
        }
    }
}


- (NSInteger)thirdObjectValue {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    return _thirdObjectValue;
}


@end
