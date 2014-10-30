//
//  aViewModel.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/29/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "aViewModel.h"

@implementation aViewModel

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
-(void)setMyIntegerProperty:(NSInteger)myIntegerProperty {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_myIntegerProperty != myIntegerProperty) {
        _myIntegerProperty = myIntegerProperty;

        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }

    }
}

-(void)setIntegerProperty:(NSInteger)integerProperty {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (_integerProperty != integerProperty) {
        _integerProperty = integerProperty;
        
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
        
    }

}

-(void)setSecondObjectValue:(NSString *)secondObjectValue {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (_secondObjectValue != secondObjectValue) {
        _secondObjectValue = secondObjectValue;
        
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
        
    }

}

- (void)setObjectValue:(double)objectValue {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    if (_objectValue != objectValue) {
        _objectValue = objectValue;
        
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
        
    }

}
#pragma clang diagnostic pop


@end
