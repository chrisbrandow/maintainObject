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
    [modelObject setValue:@(self.minimumValue) forKey:propertyKeyPath(minValue)];
    
//    [modelObject withOwner:self maintainWithModel:^(id owner, radiusSliderModel *model) {
    [modelObject withChangeInPropertiesUpdateObject:self withBlock:^(id dependentObject, id model) {
    
//        NSLog(@"hello 3rd block");

        radiusSlider *s = (radiusSlider *)dependentObject;
        s.value = [model currentValue];
        s.maximumValue = [model maxValue];
        s.minimumValue = [model minValue];
        s.tintColor = [model vmTintColor];
    }];
}
@end
