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
    [modelObject withOwner:self maintainWithModel:^(id owner, id model) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        blueViewModel *vm = model;
        blueView *v = (blueView *)owner;
        
        v.layer.cornerRadius = vm.vmCornerRadius;
        v.widthConstraint.constant = vm.vmRadius;
        v.backgroundColor = vm.vmColor;
        NSLog(@"width: %.1f", v.widthConstraint.constant);

        [self setNeedsUpdateConstraints];
    }];
}

@end
