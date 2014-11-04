//
//  axisLabel.m
//  testMaintainObject
//
//  Created by Chris Personal on 11/4/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "axisLabel.h"
#import "labelVM.h"

@implementation axisLabel

- (void)configureWithModel:(labelVM *)modelObject {


    
    modelObject.vmFrame = self.frame;
    modelObject.vmTextColor = self.textColor;
    modelObject.vmBackgroundColor = self.backgroundColor;

    [modelObject withValueChangeUpdateObject:self withBlock:^(id dependentObject, id model) {

        
        labelVM *vm = model;
        axisLabel *l = (axisLabel *)dependentObject;
        
        l.text = vm.vmText;
        l.backgroundColor = vm.vmBackgroundColor;
    }];
    
}

@end
