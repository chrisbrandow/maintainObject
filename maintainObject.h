//
//  maintainObject.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

@import Foundation;
@import UIKit;

//H/T to g8productions
#define propertyKeyPath(property) (@""#property)
#define propertyKeyPathLastComponent(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

@interface maintainObject : NSObject

- (void)withChangeInPropertiesUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
- (void)whenPropertyChanges:(NSString *)propertyName updateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;



@end
