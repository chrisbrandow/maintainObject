//
//  ViewController.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "ViewController.h"
#import "maintainObject.h"
#import "maintainLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) maintainObject *mObj;
@property (weak, nonatomic) IBOutlet maintainLabel *myOtherLabel;
@property (weak, nonatomic) IBOutlet maintainLabel *myLabel;
@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {
    [self.mObj setModelObjectValue:5.5];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mObj = [[maintainObject alloc] init];
    

    [self.mObj setModelObjectValue:4.3];
    [self.mObj setModelSecondObjectValue:@"world"];
    
    [self.myLabel configureWithModel:self.mObj];
    [self.myOtherLabel configureWithModel:self.mObj];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
