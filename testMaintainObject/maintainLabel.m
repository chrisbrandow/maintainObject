//
//  maintainLabel.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/28/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "maintainLabel.h"

@implementation maintainLabel

- (void)configureWithModel:(maintainObject *)object {



    [object withOwner:self maintainWithModel:^(id owner, maintainObject *model) {
        maintainLabel *l = (maintainLabel *)owner;
        NSLog(@"model %@", model);
        [l setText:[NSString stringWithFormat:@"%.1f hello %zd", model.objectValue, model.thirdObjectValue ]];
    }];
}

@end
