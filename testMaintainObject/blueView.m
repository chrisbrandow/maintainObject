//
//  blueView.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/31/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "blueView.h"


@implementation blueView

- (void)configureWithModel:(UIViewModel *)modelObject {
    
    modelObject.vmRadius = self.widthConstraint.constant;
    modelObject.vmColor = self.backgroundColor;
    modelObject.vmCornerRadius = self.layer.cornerRadius;
    
    [modelObject withChangeInPropertiesUpdateObject:self withBlock:^(id dependentObject, id model) {
        
        UIViewModel *vm = model;
        blueView *v = (blueView *)dependentObject;
        
        v.layer.cornerRadius = vm.vmCornerRadius;
        v.widthConstraint.constant = vm.vmRadius;
        v.backgroundColor = vm.vmColor;
    }];
}

@end
