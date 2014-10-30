//
//  aViewModel.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/29/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "aViewModel.h"

@implementation aViewModel

- (void)setMyModelInteger:(NSInteger)integerProperty {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_myIntegerProperty != integerProperty) {
        _myIntegerProperty = integerProperty;
        [self callTheBlock];
    }
}

@end
