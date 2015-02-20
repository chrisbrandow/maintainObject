//
//  blueViewModel.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/30/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "binderObject.h"

@interface UIViewModel : binderObject

@property (nonatomic) CGFloat vmCornerRadius;
@property (nonatomic) CGFloat vmRadius;
@property (nonatomic) UIColor *vmColor;

@end
