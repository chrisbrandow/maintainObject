//
//  radiusSliderModel.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "radiusSliderModel.h"

@implementation radiusSliderModel

- (void)setMaxValue:(CGFloat)maxValue {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (_maxValue != maxValue) {
        _maxValue = maxValue;
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
    }
    
}

- (void)setCurrentValue:(CGFloat)currentValue {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (_currentValue != currentValue) {
        _currentValue = currentValue;
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
    }
    
}

@end
