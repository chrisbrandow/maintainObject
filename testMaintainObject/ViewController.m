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
@property (nonatomic) aViewModel *mObj;
@property (nonatomic) aViewModel *test;
@property (weak, nonatomic) IBOutlet maintainLabel *myOtherLabel;
@property (weak, nonatomic) IBOutlet maintainLabel *myLabel;
@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {

    [self.mObj setIntegerProperty:32];
    [self.mObj setSecondObjectValue:@"universe"];
    [self.test setMyIntegerProperty:198];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mObj = [[aViewModel alloc] init];
    self.test = [[aViewModel alloc] init];
    
    __block NSInteger aNumber = 5;
    NSLog(@"anumber %zd",aNumber);

    [self.test withOwner:self maintainWithModel:^(id owner, aViewModel *model) {
        NSLog(@"self.test block####");

        NSLog(@"se;f.mobj block####");
        
        aNumber = model.myIntegerProperty;
        NSString *temp = [[owner myLabel] text];
        temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%zd", model.myIntegerProperty]];
        [[owner myLabel] setText:temp];
        NSLog(@"temp: %@", temp);
    }];
    self.test.myIntegerProperty = 57;
    NSLog(@"anumber %zd",aNumber);

    
    [self.mObj setObjectValue:4.3];
    [self.mObj setSecondObjectValue:@"le la la"];
//    [self.myLabel configureWithModel:self.mObj];
    
    [self.mObj withOwner:self maintainWithModel:^(id owner, aViewModel *model) {
        NSLog(@"se;f.mobj block####");

        ViewController *vc = (ViewController *)owner;
        [[vc myOtherLabel] setText:[NSString stringWithFormat:@"->%@", model.secondObjectValue]];
    }];
    [self.mObj setSecondObjectValue:@"la la la"];


//    [self.myOtherLabel configureWithModel:self.mObj];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
