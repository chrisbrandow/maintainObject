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
    
    
    self.demoViewModel = [[blueViewModel alloc] init];
    self.demoView.widthConstraint = self.viewWidthConstraint;
    self.demoViewModel.vmColor = [UIColor greenColor];
    
    
    self.radiusSliderVM = [[radiusSliderModel alloc] init];
    
    
    self.cornerRadiusSliderVM = [[cornerRadiusModel alloc] init];

    //[thingThatsChanging withOwner:thingThatNeedsToChangeWithIt
    [self.radiusSliderVM withOwner:self.demoViewModel maintainWithModel:^(id owner, id model) {
        [owner setVmRadius:[model currentValue]];
        
    }];
    
    [self.radiusSliderVM withOwner:self.cornerRadiusSliderVM maintainWithModel:^(id owner, id model) {
        NSLog(@"hello 2nd block");
        [owner setMaxValue:[model currentValue]/2];
    }];
    
    [self.demoView configureWithModel:self.demoViewModel];
    [self.radiusSlider configureWithModel:self.radiusSliderVM];
    [self.cornerRadiusSlider configureWithModel:self.cornerRadiusSliderVM];
    self.demoViewModel.vmRadius = 200;
    self.radiusSliderVM.maxValue = 300;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)radiusSliderUpdated:(id)sender {
    UISlider *s = (UISlider *)sender;
    self.demoViewModel.vmRadius = s.value;
//    self.viewWidthConstraint.constant = s.value;
    NSLog(@"self cRMax: %.1f", self.cornerRadiusSlider.maximumValue);

}
- (IBAction)cornerRadiusSliderUpdated:(id)sender {

    UISlider *s = (UISlider *)sender;
    NSLog(@"valval %.1f", s.value);
//    self.demoViewModel.vmCornerRadius = s.value;
//    self.radiusSliderVM.maxValue = s.value;
//finish setting the models
    CGFloat rsvmMax = self.radiusSliderVM.maxValue;
    CGFloat rsvmCurrent = self.radiusSliderVM.currentValue;
    //if the corner radius < current radius value then
    // set current radius = current corner radius.
    // otherwise leave it alone;
    

}

- (IBAction)segmentedControllerUpdated:(id)sender {
    
}

@end
