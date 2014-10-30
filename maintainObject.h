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

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock;

- (void)setModelObjectValue:(double)dParameter;
- (void)setModelSecondObjectValue:(NSString *)string;
- (void)callTheBlock;

@property (nonatomic, readonly) double objectValue;
@property (nonatomic, setter=setTheSecond:) NSString *secondObjectValue;


@property (nonatomic, setter=setModelInteger:) NSInteger integerProperty;


@end
