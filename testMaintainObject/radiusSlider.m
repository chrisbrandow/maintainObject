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
    
    modelObject.maxValue = self.maximumValue;
    modelObject.currentValue = self.value;
    modelObject.minValue = self.minimumValue;
    
    [modelObject withOwner:self maintainWithModel:^(id owner, radiusSliderModel *model) {
        NSLog(@"hello 3rd block");

        radiusSlider *s = (radiusSlider *)owner;
        s.value = [model currentValue];
        s.maximumValue = [model maxValue];
        s.minimumValue = [model minValue];
        
    }];
}
@end
