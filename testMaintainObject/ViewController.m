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

#import "radiusSliderModel.h"
#import "radiusSlider.h"
#import "blueViewModel.h"
#import "blueView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) radiusSliderModel *radiusSliderVM;
@property (nonatomic) radiusSliderModel *cornerRadiusSliderVM;
@property ( nonatomic) blueViewModel *demoViewModel;

@property (weak, nonatomic) IBOutlet blueView *demoView;
@property (weak, nonatomic) IBOutlet radiusSlider *radiusSlider;
@property (weak, nonatomic) IBOutlet radiusSlider *cornerRadiusSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegmentedControl;

@property (nonatomic) NSArray *colors;

@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]];

    self.radiusSliderVM = [[radiusSliderModel alloc] init];
    self.cornerRadiusSliderVM = [[radiusSliderModel alloc] init];
    self.demoViewModel = [[blueViewModel alloc] init];
    
    [self.radiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
        NSLog(@"hello 1st block");
        [[owner demoViewModel] setVmRadius:[model currentValue]];
        [[owner cornerRadiusSliderVM] setMaxValue:[model currentValue]/2];
        if ([owner cornerRadiusSliderVM].currentValue > [model currentValue]/2) {
            [[owner cornerRadiusSliderVM] setCurrentValue:[model currentValue]/2];
        }
        
    }];
    
    [self.cornerRadiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
        [[owner demoViewModel] setVmCornerRadius:[model currentValue]];
    }];
    
    [self.demoView configureWithModel:self.demoViewModel];
    [self.radiusSlider configureWithModel:self.radiusSliderVM];
    [self.cornerRadiusSlider configureWithModel:self.cornerRadiusSliderVM];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)radiusSliderUpdated:(id)sender {
    UISlider *s = (UISlider *)sender;
    self.radiusSliderVM.currentValue = s.value;
    
}
- (IBAction)cornerRadiusSliderUpdated:(id)sender {

    UISlider *s = (UISlider *)sender;
    self.cornerRadiusSliderVM.currentValue = s.value;

}

- (IBAction)segmentedControllerUpdated:(id)sender {
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    self.demoViewModel.vmColor = self.colors[sc.selectedSegmentIndex];
}

@end
