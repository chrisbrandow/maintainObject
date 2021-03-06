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
#define keyPath(property) (@""#property)
#define objProperty(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

@interface binderObject : NSObject
- (void)bind:(id)boundObject toPropertiesInBlock:(void (^)(id boundObject, id model))maintenanceBlock;
- (void)bind:(id)boundObject toProperty:(NSString *)propertyName InBlock:(void (^)(id, id))maintenanceBlock;
- (void)bindView:(UIView *)view toPropertiesInBlock:(void (^)(id boundObject, id model))maintenanceBlock;
//imperatively trigger an initiate or terminate block
- (void)property:(NSString *)propertyName startOrStopped:(valueChange)change;
- (void)whenProperty:(NSString *)propertyName changesBy:(valueChange)startOrStop updateBlock:(void (^)(id boundObject, id model))maintenanceBlock;

- (void)withChangeInPropertiesUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
- (void)whenPropertyChanges:(NSString *)propertyName updateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
- (void)updateView:(UIView *)view withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;

- (void)property:(NSString *)propertyName stopOrStartChanging:(valueChange)startOrStop;
- (void)whenProperty:(NSString *)propertyName startsOrStopsChanging:(valueChange)startOrStop updateBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
@end
