//
//  axisLabel.m
//  testMaintainObject
//
//  Created by Chris Personal on 11/4/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "axisLabel.h"
#import "UILabelVM.h"

@implementation axisLabel

- (void)configureWithModel:(UILabelVM *)modelObject {

    modelObject.vmFrame = self.frame;
    modelObject.vmTextColor = self.textColor;
    modelObject.vmBackgroundColor = self.backgroundColor;

    [modelObject updateView:self withBlock:^(id dependentObject, id model) {
        
        UILabelVM *vm = model;
        axisLabel *l = (axisLabel *)dependentObject;
        
        l.text = vm.vmText;
        l.backgroundColor = vm.vmBackgroundColor;
        l.layer.cornerRadius = vm.vmCornerRadius;
        l.layer.masksToBounds = YES;
    }];
    
}

@end
