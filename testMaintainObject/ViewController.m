//
//  ViewController.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "ViewController.h"
#import "binderObject.h"
#import "UILabelModel.h"
#import "axisLabel.h"
#import "sliderBinder.h"
#import "boundSlider.h"
#import "UIViewModel.h"
#import "changingView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) sliderBinder *radiusSliderVM;
@property (nonatomic) sliderBinder *cornerRadiusSliderVM;
@property (nonatomic) UIViewModel *demoViewModel;

@property (weak, nonatomic) IBOutlet changingView *demoView;
@property (weak, nonatomic) IBOutlet boundSlider *radiusSlider;
@property (weak, nonatomic) IBOutlet boundSlider *cornerRadiusSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegmentedControl;

@property (nonatomic) NSArray *colors;

@property (weak, nonatomic) IBOutlet axisLabel *radiusMaxLabel;

@property (weak, nonatomic) IBOutlet axisLabel *radiusMinLabel;
@property (weak, nonatomic) IBOutlet axisLabel *cornerRadiusMinLabel;
@property (weak, nonatomic) IBOutlet axisLabel *cornerRadiusMaxLabel;

@property (nonatomic) UILabelModel *crMinLabelVM;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]];

    [self setInitialViewModelRelationships];
    
    [self.cornerRadiusMaxLabel configureWithModel:self.crMinLabelVM];
    [self.demoView configureWithModel:self.demoViewModel];
    [self.radiusSlider configureWithModel:self.radiusSliderVM];
    [self.cornerRadiusSlider configureWithModel:self.cornerRadiusSliderVM];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.crMinLabelVM.vmCornerRadius = 5;
    self.crMinLabelVM.vmBackgroundColor = [UIColor whiteColor];
    self.cornerRadiusSliderVM.vmTintColor = [UIColor blueColor];

}

- (void)setInitialViewModelRelationships {
    
    self.radiusSliderVM = [sliderBinder new];
    self.cornerRadiusSliderVM = [sliderBinder new];
    self.demoViewModel = [UIViewModel new];
    self.crMinLabelVM = [UILabelModel new];
    
    //set demoViewModel properties based on any changes to sliders
//    [self.radiusSliderVM bind:self.demoViewModel toPropertiesInBlock:^(id boundObject, id model) {
//        [boundObject setVmRadius:[model currentValue]];
//    }];
    [self.radiusSliderVM whenPropertyChanges:keyPath(currentValue) updateObject:self.demoViewModel withBlock:^(id dependentObject, id model) {
        [dependentObject setVmRadius:[model currentValue]];
    }];
    
    [self.cornerRadiusSliderVM whenPropertyChanges:keyPath(currentValue) updateObject:self.demoViewModel withBlock:^(id dependentObject, id model) {
        [dependentObject setVmCornerRadius:[model currentValue]];
    }];
    
    //modify second slider max value so that it is always <= 1/2 of the view's "radius"
    [self.radiusSliderVM whenPropertyChanges:keyPath(currentValue) updateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        //typecasting allows dot-syntax to be used.
        sliderBinder *crVM = (sliderBinder *)dependentObject;
        CGFloat newMaxValue = [model currentValue]/2;
        
        crVM.maxValue = (newMaxValue) ?: 1;
        
        if ([dependentObject currentValue] > newMaxValue) {
            crVM.currentValue = (newMaxValue >=1) ? newMaxValue : 1;
        }
        
    }];
    
    [self.radiusSliderVM whenPropertyChanges:keyPath(currentValue) updateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmBackgroundColor:[UIColor redColor]];
    }];
    
    [self.cornerRadiusSliderVM whenPropertyChanges:keyPath(maxValue) updateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmTintColor:([model currentValue] >= [model maxValue]) ? [UIColor redColor] : [UIColor blueColor]];
    }];

    [self.cornerRadiusSliderVM whenPropertyChanges:keyPath(maxValue) updateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        
        NSString *labelString = [NSString stringWithFormat:@"%.0f", ([model maxValue] > 1) ? [model maxValue] : 1];
        [dependentObject setVmText:labelString];

    }];

    [self.radiusSliderVM whenProperty:keyPath(currentValue) startsOrStopsChanging:changeStop updateBlock:^(id dependentObject, id model) {
        
        self.crMinLabelVM.vmBackgroundColor = [UIColor whiteColor];
        self.cornerRadiusSliderVM.vmTintColor = [UIColor blueColor];

    }];
    [self.radiusSliderVM whenProperty:keyPath(currentValue) startsOrStopsChanging:changeStart updateBlock:^(id dependentObject, id model) {
        self.radiusSlider.backgroundColor = [UIColor redColor];
        [UIView animateWithDuration:.5 animations:^{
            self.radiusSlider.backgroundColor = [UIColor whiteColor];
        }];
    }];
}

- (IBAction)segmentedControllerUpdated:(id)sender {
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    self.demoViewModel.vmColor = self.colors[sc.selectedSegmentIndex];
}


@end
