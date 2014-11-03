//
//  maintainObject.h
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface maintainObject : NSObject {
    NSMapTable *_maintenanceBlocksByOwner;

}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock;





@end
