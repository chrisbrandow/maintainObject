//
//  radiusSliderModel.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "binderObject.h"

@interface sliderBinder : binderObject

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat currentValue;
@property (nonatomic) UIColor *vmTintColor;

@end
