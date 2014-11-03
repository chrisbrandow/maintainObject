//
//  subClassMaintain.m
//  testMaintainObject
//
//  Created by Chris Personal on 11/3/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "subClassMaintain.h"

@implementation subClassMaintain

- (void)setThirdProp:(double)thirdProp {
    if (_thirdProp != thirdProp) {
        _thirdProp = thirdProp;
        _thirdProp = [self thirdProp];
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
    }
}


- (void)setFourthProp:(NSString *)fourthProp {
    if (![_fourthProp isEqual:fourthProp]) {
        _fourthProp = fourthProp;
        _fourthProp = [self fourthProp];
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
    }
}


@end
