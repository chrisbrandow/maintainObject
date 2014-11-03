//
//  cRadiusSlider.m
//  testMaintainObject
//
//  Created by Chris Personal on 11/2/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "cRadiusSlider.h"

@implementation cRadiusSlider

- (void)configureWithModel:(radiusSliderModel *)modelObject {
    
    
    
    [modelObject withOwner:self maintainWithModel:^(id owner, id model) {
        radiusSliderModel *m = model;
        NSLog(@"cRadius config block: %.1f", m.maxValue);
        cRadiusSlider *s = (cRadiusSlider *)owner;

        [s setMaximumValue:m.maxValue];
        s.value = m.currentValue;

        
    }];
    
}
@end
