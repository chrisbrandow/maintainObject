//
//  blueViewModel.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "blueViewModel.h"

@implementation blueViewModel

- (void)setVmCornerRadius:(CGFloat)vmCornerRadius {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_vmCornerRadius != vmCornerRadius) {
        _vmCornerRadius = vmCornerRadius;
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
    }
}

- (void)setVmRadius:(CGFloat)vmRadius {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_vmRadius != vmRadius) {
        _vmRadius = vmRadius;
        if ([self respondsToSelector:@selector(callTheBlock)]) {
            [self performSelector:@selector(callTheBlock)];
        }
    }
}
@end
