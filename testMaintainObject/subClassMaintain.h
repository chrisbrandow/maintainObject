//
//  subClassMaintain.h
//  testMaintainObject
//
//  Created by Chris Personal on 11/3/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "maintainObject.h"

@interface subClassMaintain : maintainObject

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock;

@property (nonatomic) double thirdProp;
@property (nonatomic) NSString *fourthProp;

@end
