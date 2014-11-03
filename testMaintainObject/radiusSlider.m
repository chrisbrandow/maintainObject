//
//  radiusSlider.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "radiusSlider.h"

@implementation radiusSlider

- (void)configureWithModel:(radiusSliderModel *)modelObject {
    
    
    
    [modelObject withOwner:self maintainWithModel:^(id owner, radiusSliderModel *model) {
        NSLog(@"%s", __PRETTY_FUNCTION__);

        radiusSlider *s = (radiusSlider *)owner;
//        s.value = model.currentValue;
        NSLog(@"max: %.1f", model.maxValue);
        NSLog(@"current: %.1f", model.currentValue);

        [s setMaximumValue:model.maxValue];
    
        NSLog(@"s.val %.1f", s.maximumValue);

    }];
}
@end
