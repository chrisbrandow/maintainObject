//
//  maintainObject.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef enum valueChange : NSUInteger {
    changeStart,
    changeStop,
} valueChange;

//H/T to g8productions
#define propertyKeyPath(property) (@""#property)
#define propertyComponent(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

@interface maintainObject : NSObject

- (void)withChangeInPropertiesUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
- (void)whenPropertyChanges:(NSString *)propertyName updateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
- (void)updateView:(UIView *)view withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;

- (void)property:(NSString *)propertyName stopOrStartChanging:(valueChange)startOrStop;
- (void)whenProperty:(NSString *)propertyName startsOrStopsChanging:(valueChange)startOrStop updateBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
@end
