//
//  maintainObject.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "maintainObject.h"
#import <objc/runtime.h> 

@interface maintainObject ()

@end
static IMP __original_Method_Imp;

@implementation maintainObject
@synthesize integerProperty = _integerProperty;
@synthesize objectValue = _objectValue;
//@synthesize secondObjectValue = _secondObjectValue;
- (void) swizzleExample //call me to swizzle
{
    
    //find setters
    int unsigned numMethods;
    Method *methods = class_copyMethodList(objc_getClass("maintainObject"), &numMethods);
//    NSMutableArray *setters = [NSMutableArray new];
    for (int i = 0; i < numMethods; i++) {
        if ([NSStringFromSelector(method_getName(methods[i])) containsString:@"set"]) {
        
            NSLog(@"->%@", NSStringFromSelector(method_getName(methods[i])));
//            NSLog(@"swizForward: %@", [self forwardingTargetForSelector:method_getName(methods[i])]);
            //I think that based on: http://www.bignerdranch.com/blog/inside-the-bracket-part-7-runtime-machinations/
            //"The second method calls the original implementation. This code isn't replacing the original code, just augmenting it."
            //I should just be swizzling the code as he says.
            //I should swap them, call the one that runs the setter, call it's swizzled self, which will call the other method.
            //maybe
//            [maintainObject synthesizeForwarder:NSStringFromSelector(method_getName(methods[i]))];
//            Method m = class_getInstanceMethod([self class], method_getName(methods[i]));
//            __original_Method_Imp = method_setImplementation(m, (IMP)_replacement_Method);
        }
    }

    //swizzle those methods to a generic method that takes the method name
    //and runs the method, then runs maintainblock?
    

}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSLog(@"hello erreone %@", NSStringFromSelector(selector));
    // Setter signature for a NSString
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSLog(@"invocation: %@", NSStringFromSelector(invocation.selector));
    // Get the NSString to set
    __unsafe_unretained NSString *s;
    [invocation getArgument:&s atIndex:2];

//    [self setSecondObjectValue:s];
    //    __unsafe_unretained NSString *ss;
//    [invocation getArgument:&ss atIndex:2];
//    invo
//    self setValue:s forKey:[self methodSignatureForSelector:<#(SEL)#>]
    _secondObjectValue = s;
    [self callTheBlock];
    NSLog(@"The string is: %@",s);
}
- (id)init {
    self = [super init];
    
    if (self) {
        _maintenanceBlocksByOwner = [NSMapTable weakToStrongObjectsMapTable];
    }

    NSLog(@"init object");

    [self swizzleExample];
    return self;
}

- (void)withOwner:(id)weaklyHeldOwner maintainWithModel:(void (^)(id owner, id model))maintenanceBlock {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    NSMutableArray *maintenanceBlocksForOwner = [_maintenanceBlocksByOwner objectForKey:weaklyHeldOwner];
    if (!maintenanceBlocksForOwner) {
        maintenanceBlocksForOwner = [NSMutableArray array];
        [_maintenanceBlocksByOwner setObject:maintenanceBlocksForOwner forKey:weaklyHeldOwner];
    }
    
    [maintenanceBlocksForOwner addObject:maintenanceBlock];
    maintenanceBlock(weaklyHeldOwner, self);
}

- (void)setModelObjectValue:(double)objectValue {
    if (_objectValue != objectValue) {
        NSLog(@"one");
        _objectValue = objectValue;
        objectValue = [self objectValue];
        [self callTheBlock];

    }
}



//- (void)setModelSecondObjectValue:(NSString *)secondObjectValue {
//    NSLog(@"_obj %@, obj %@", _secondObjectValue, secondObjectValue);
//    if (![_secondObjectValue isEqual:secondObjectValue]) {
//
//        _secondObjectValue = secondObjectValue;
//        secondObjectValue = [self secondObjectValue];
//
//        [self callTheBlock];
//
//    }
//}
- (id)performSelector:(SEL)aSelector withObject:(id)object {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self performSelector:aSelector withObject:object];
}
- (id)performSelector:(SEL)aSelector {
    NSLog(@"here we are");
    
    return [super performSelector:aSelector];
    
    
}
- (void)callTheBlock {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    for (id owner in _maintenanceBlocksByOwner) {
        for (void (^maintenanceBlock)(id owner, maintainObject *model) in
             [_maintenanceBlocksByOwner objectForKey:owner]) {
            maintenanceBlock(owner, self);
        }
    }
}

- (void)setModelInteger:(NSInteger)integerProperty {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (_integerProperty != integerProperty) {
        _integerProperty = integerProperty;
        [self callTheBlock];
    }
}




@end
