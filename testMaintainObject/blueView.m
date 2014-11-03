//
//  blueView.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/31/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "blueView.h"


@implementation blueView

- (void)configureWithModel:(blueViewModel *)modelObject {
    
    modelObject.vmRadius = self.widthConstraint.constant;
    modelObject.vmColor = self.backgroundColor;
    modelObject.vmCornerRadius = self.layer.cornerRadius;
    
    [modelObject withOwner:self maintainWithModel:^(id owner, id model) {
        blueViewModel *vm = model;
        blueView *v = (blueView *)owner;
        
        v.layer.cornerRadius = vm.vmCornerRadius;
        v.widthConstraint.constant = vm.vmRadius;
        v.backgroundColor = vm.vmColor;
    }];
}

@end
