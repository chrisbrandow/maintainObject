//
//  blueView.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/31/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "blueViewModel.h"

@interface blueView : UIView

@property (nonatomic) NSLayoutConstraint *widthConstraint;

- (void)configureWithModel:(blueViewModel *)modelObject;

@end
