//
//  maintainObject.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface maintainObject : NSObject {
    NSMapTable *_maintenanceBlocksByOwner;

}

- (void)withOwner:(id)weaklyHeldOwner maintain:(void (^)(id owner, id objValue, id secObjValue, maintainObject *model))maintenanceBlock;
- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, maintainObject *model))maintenanceBlock;

- (void)setModelObjectValue:(double)dParameter;
- (void)setModelSecondObjectValue:(NSString *)string;

@property (nonatomic, readonly) double objectValue;
@property (nonatomic, readonly) NSString *secondObjectValue;

@property (nonatomic, readonly) NSInteger thirdObjectValue;


@end
