//
//  ViewController.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "ViewController.h"
#import "maintainObject.h"
#import "subClassMaintain.h"
#import "maintainLabel.h"
#import "aViewModel.h"
#import "cornerRadiusModel.h"
#import "radiusSliderModel.h"
#import "cRadiusSlider.h"
#import "radiusSlider.h"
#import "blueViewModel.h"
#import "blueView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) radiusSliderModel *radiusSliderVM;
@property (nonatomic) cornerRadiusModel *cornerRadiusSliderVM;
@property (nonatomic) maintainObject *test2Blocks;
@property (nonatomic) subClassMaintain *test3Blocks;



@property (weak, nonatomic) IBOutlet blueView *demoView;
@property ( nonatomic) blueViewModel *demoViewModel;
@property (weak, nonatomic) IBOutlet radiusSlider *radiusSlider;
@property (weak, nonatomic) IBOutlet cRadiusSlider *cornerRadiusSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegmentedControl;
//What I would like to show would be that as overall radius changes,
//the scale of radiusslider changes  AND if the radius gets to be < cornerradius/2
//that cornerradius autoscales down (in the model then the view)

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstraint;

@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.test2Blocks = [[maintainObject alloc] init];
//    
//    [self.test2Blocks withOwner:self maintainWithModel:^(id owner, id model) {
//        [[[owner demoView] layer] setCornerRadius:[model firstProp]];
//        NSLog(@"test2 + 3rd block");
//
//    }];
//    
//
//    
//    [self.test2Blocks withOwner:self maintainWithModel:^(id owner, id model) {
//        [[owner colorSegmentedControl] setTitle:[NSString stringWithFormat:@"%@",[model secondProp]] forSegmentAtIndex:2];
//        NSLog(@"test2 + 2nd block %@", [NSString stringWithFormat:@"%@",[model secondProp]]);
//    }];
    
    self.test3Blocks = [[subClassMaintain alloc] init];
    self.demoView.layer.borderColor = [UIColor greenColor].CGColor;
    [self.test3Blocks withOwner:self maintainWithModel:^(id owner, id model) {
        [[[owner demoView] layer] setBorderWidth:[model thirdProp]];
        NSLog(@"happening in test3");
    }];
    self.test3Blocks.thirdProp = 1;
    
    
    [self.test3Blocks withOwner:self maintainWithModel:^(id owner, id model) {
        [[owner colorSegmentedControl] setTitle:[NSString stringWithFormat:@"%@",[model fourthProp]] forSegmentAtIndex:3];
    }];
//    self.demoViewModel = [[blueViewModel alloc] init];
//    self.demoView.widthConstraint = self.viewWidthConstraint;
//    self.demoViewModel.vmColor = [UIColor greenColor];
//    
//    
    self.radiusSliderVM = [[radiusSliderModel alloc] init];
//
//    
//    self.cornerRadiusSliderVM = [[cornerRadiusModel alloc] init];
//
//    //[thingThatsChanging withOwner:thingThatNeedsToChangeWithIt
    [self.radiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
        [[owner demoViewModel] setVmRadius:[model currentValue]];
        
    }];
    
    [self.radiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
        NSLog(@"hello 2nd block");
        [[owner cornerRadiusSliderVM] setMaxValue:[model currentValue]/2];
    }];
//
//    [self.demoView configureWithModel:self.demoViewModel];
//    [self.radiusSlider configureWithModel:self.radiusSliderVM];
//    [self.cornerRadiusSlider configureWithModel:self.cornerRadiusSliderVM];
//    self.demoViewModel.vmRadius = 200;
//    self.radiusSliderVM.maxValue = 300;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)radiusSliderUpdated:(id)sender {
    UISlider *s = (UISlider *)sender;
//    self.demoViewModel.vmRadius = s.value;
//    self.viewWidthConstraint.constant = s.value;
    [self.test2Blocks setFirstProp:s.value];
    [self.test2Blocks setSecondProp:[NSString stringWithFormat:@"%.1f",s.value]];
    NSLog(@"self cRMax: %@: %@", [NSString stringWithFormat:@"%.1f",s.value], self.test2Blocks.secondProp);

}
- (IBAction)cornerRadiusSliderUpdated:(id)sender {

    UISlider *s = (UISlider *)sender;
    NSLog(@"valval %.1f", s.value);
//    self.demoViewModel.vmCornerRadius = s.value;
//    self.radiusSliderVM.maxValue = s.value;
//finish setting the models
//    CGFloat rsvmMax = self.radiusSliderVM.maxValue;
//    CGFloat rsvmCurrent = self.radiusSliderVM.currentValue;
    //if the corner radius < current radius value then
    // set current radius = current corner radius.
    // otherwise leave it alone;
    [self.test3Blocks setThirdProp:s.value];
    [self.test3Blocks setFourthProp:[NSString stringWithFormat:@"%.1f",s.value]];


}

- (IBAction)segmentedControllerUpdated:(id)sender {
    
}

@end
