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
#define setModelPrimitiveValueForPropertyName(model, value, propertyName) [model setValue:@(value) forKeyPath:propertyKeyPath(propertyName)]
#define setModelValueForPropertyName(model, value, propertyName) [model setValue:value forKeyPath:propertyKeyPath(propertyName)]

@interface maintainObject : NSObject {
    NSMapTable *_maintenanceBlocksByOwner;

}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock;
- (void)withValueChangeUpdateObject:(id)weaklyHeldOwner withBlock:(void (^)(id dependentObject, id model))maintenanceBlock;
- (void)setupObservingWithKeys:(NSArray *)keys;
+ (NSArray *)propertyKeys;



@end
