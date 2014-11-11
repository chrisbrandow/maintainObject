//
//  radiusSliderModel.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "maintainObject.h"

@interface sliderModel : maintainObject

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat currentValue;
@property (nonatomic) UIColor *vmTintColor;

@end
