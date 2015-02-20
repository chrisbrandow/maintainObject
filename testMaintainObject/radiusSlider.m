//
//  radiusSlider.m
//  testMaintainObject
//
//  Created by Christopher Brandow on 2/19/15.
//  Copyright (c) 2015 Flouu Apps. All rights reserved.
//

#import "radiusSlider.h"

@implementation radiusSlider

-(void)configureWithModel:(sliderBinder *)modelObject {
    [super configureWithModel:modelObject];
    
    [modelObject setValue:@(self.maximumValue) forKey:objProperty(maxValue)];
    [modelObject setValue:@(self.value) forKey:objProperty(currentValue)];
    self.layer.cornerRadius = 5;
    
    [modelObject updateView:self withBlock:^(id dependentObject, id model) {

        boundSlider *s = (boundSlider *)dependentObject;
        s.value = [model currentValue];
        s.maximumValue = [model maxValue];
        s.tintColor = [model vmTintColor];
    }];
}
@end
