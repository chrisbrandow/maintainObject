//
//  radiusSlider.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sliderBinder.h"

@interface boundSlider : UISlider

- (void)configureWithModel:(sliderBinder *)modelObject;

@end
