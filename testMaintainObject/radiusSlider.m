//
//  radiusSlider.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "radiusSlider.h"

@implementation radiusSlider

- (void)configureWithModel:(sliderModel *)modelObject {
    
    
    [modelObject setValue:@(self.maximumValue) forKey:propertyKeyPath(maxValue)];
    [modelObject setValue:@(self.value) forKey:propertyKeyPath(currentValue)];
    self.layer.cornerRadius = 5;
    
    [modelObject updateView:self withBlock:^(id dependentObject, id model) {
        
        radiusSlider *s = (radiusSlider *)dependentObject;
        s.value = [model currentValue];
        s.maximumValue = [model maxValue];
        s.tintColor = [model vmTintColor];
    }];
}
@end
