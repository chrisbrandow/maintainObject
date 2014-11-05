//
//  ViewController.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "ViewController.h"
#import "maintainObject.h"
#import "UILabelVM.h"
#import "axisLabel.h"
#import "sliderModel.h"
#import "radiusSlider.h"
#import "UIViewModel.h"
#import "blueView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) sliderModel *radiusSliderVM;
@property (nonatomic) sliderModel *cornerRadiusSliderVM;
@property ( nonatomic) UIViewModel *demoViewModel;

@property (weak, nonatomic) IBOutlet blueView *demoView;
@property (weak, nonatomic) IBOutlet radiusSlider *radiusSlider;
@property (weak, nonatomic) IBOutlet radiusSlider *cornerRadiusSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegmentedControl;

@property (nonatomic) NSArray *colors;

@property (weak, nonatomic) IBOutlet axisLabel *radiusMaxLabel;

@property (weak, nonatomic) IBOutlet axisLabel *radiusMinLabel;
@property (weak, nonatomic) IBOutlet axisLabel *cornerRadiusMinLabel;
@property (weak, nonatomic) IBOutlet axisLabel *cornerRadiusMaxLabel;

@property (nonatomic) UILabelVM *crMinLabelVM;


@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]];


    self.radiusSliderVM = [sliderModel new];
    
    self.cornerRadiusSliderVM = [sliderModel new];
    self.demoViewModel = [UIViewModel new];
    self.crMinLabelVM = [UILabelVM new];

    [self setInitialViewModelRelationships];
    
    [self.cornerRadiusMaxLabel configureWithModel:self.crMinLabelVM];
    [self.demoView configureWithModel:self.demoViewModel];
    [self.radiusSlider configureWithModel:self.radiusSliderVM];
    [self.cornerRadiusSlider configureWithModel:self.cornerRadiusSliderVM];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.crMinLabelVM.vmCornerRadius = 5;
    self.cornerRadiusSliderVM.vmTintColor = [UIColor blueColor];
}

- (void)setInitialViewModelRelationships {
    
    
    [self.radiusSliderVM withChangeInPropertiesUpdateObject:self.demoViewModel withBlock:^(id dependentObject, id model) {
        [dependentObject setVmRadius:[model currentValue]];
    }];
    
    [self.radiusSliderVM withChangeInPropertiesUpdateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        sliderModel *crVM = (sliderModel *)dependentObject;
        
        crVM.maxValue = [model currentValue]/2;
        
        if ([dependentObject currentValue] > [model currentValue]/2) {
            [dependentObject setValue:@([model currentValue]/2) forKey:propertyKeyPath(currentValue)];
        }
    }];
    
    [self.cornerRadiusSliderVM withChangeInPropertiesUpdateObject:self withBlock:^(id dependentObject, id model) {
        [[dependentObject demoViewModel] setVmCornerRadius:[model currentValue]];
    }];
    
    [self.cornerRadiusSliderVM withChangeInPropertiesUpdateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmText:[NSString stringWithFormat:@"%.0f",[model maxValue]] ];
    }];
    
    [self.radiusSliderVM whenPropertyChanges:propertyKeyPath(currentValue) updateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmBackgroundColor:[UIColor redColor]];
    }];
    
    [self.cornerRadiusSliderVM whenPropertyChanges:propertyKeyPath(currentValue) updateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmTintColor:[UIColor redColor]];
    }];

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
- (IBAction)radiusSliderFinishedWithRadius:(id)sender {
    self.crMinLabelVM.vmBackgroundColor = [UIColor whiteColor];

}
- (IBAction)cornerRadiusSliderFinished:(id)sender {
    self.cornerRadiusSliderVM.vmTintColor =[UIColor blueColor];

}

@end
