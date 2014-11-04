//
//  labelVM.h
//  testMaintainObject
//
//  Created by Chris Personal on 11/4/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "maintainObject.h"

@interface labelVM : maintainObject <NSCoding>

@property (nonatomic) CGRect vmFrame;
@property (nonatomic) NSString *vmText;
@property (nonatomic) UIColor *vmTextColor;
@property (nonatomic) UIColor *vmBackgroundColor;

@property (nonatomic, readonly) IBOutlet UILabel *boundLabel;

@end
