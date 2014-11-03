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
        NSLog(@"hello 3rd block");

        radiusSlider *s = (radiusSlider *)owner;

        s.tintColor = [UIColor colorWithWhite:(.1+.9*(model.currentValue/.9)) alpha:1];

    }];
}
@end
