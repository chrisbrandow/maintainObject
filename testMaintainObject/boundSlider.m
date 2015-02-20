//
//  radiusSlider.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "boundSlider.h"

@interface boundSlider ()

@property (nonatomic) sliderBinder *model;

@end

@implementation boundSlider

- (void)configureWithModel:(sliderBinder *)modelObject {
    
    self.model = modelObject;
    
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    [self.model property:keyPath(currentValue) stopOrStartChanging:changeStart];
    return YES;

}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    self.model.currentValue = (self.value) ?: 1;

    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    [self.model property:keyPath(currentValue) stopOrStartChanging:changeStop];

}
@end
