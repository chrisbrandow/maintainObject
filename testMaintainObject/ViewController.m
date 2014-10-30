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
#import "aViewModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) maintainObject *mObj;
@property (weak, nonatomic) IBOutlet maintainLabel *myOtherLabel;
@property (weak, nonatomic) IBOutlet maintainLabel *myLabel;
@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {

    [self.mObj setModelInteger:32];
    [self.mObj setModelSecondObjectValue:@"universe"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mObj = [[maintainObject alloc] init];

//    aViewModel *test = [[aViewModel alloc] init];
//    __block NSInteger aNumber = 5;
//    NSLog(@"anumber %zd",aNumber);
//
//    [test withOwner:self maintainWithModel:^(id owner, aViewModel *model) {
//        aNumber = model.myIntegerProperty;
//    }];
//    NSLog(@"anumber %zd",aNumber);
//    test.myIntegerProperty = 57;
//
//    NSLog(@"anumber %zd",aNumber);

    
    [self.mObj setModelObjectValue:4.3];
//    [self.mObj setModelSecondObjectValue:@"world"];
    [self.mObj setTheSecond:@"le la la"];
    [self.myLabel configureWithModel:self.mObj];
    [self.mObj withOwner:self maintainWithModel:^(id owner, maintainObject *model) {
        ViewController *vc = (ViewController *)owner;
        [[vc myOtherLabel] setText:[NSString stringWithFormat:@"->%@", model.secondObjectValue]];
    }];
    [self.mObj setTheSecond:@"la la la"];


//    [self.myOtherLabel configureWithModel:self.mObj];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
