//
//  aViewModel.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/29/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "maintainObject.h"
@interface aViewModel : maintainObject

@property (nonatomic) NSInteger myIntegerProperty;
@property (nonatomic) double objectValue;
@property (nonatomic) NSString *secondObjectValue;
@property (nonatomic) NSInteger integerProperty;

@property (nonatomic) CGFloat radius;
@property (nonatomic) UIColor *color;
@property (nonatomic) CGFloat borderRadius;

@end
