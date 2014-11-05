//
//  blueView.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/31/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewModel.h"

@interface blueView : UIView

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *widthConstraint;

- (void)configureWithModel:(UIViewModel *)modelObject;

@end
