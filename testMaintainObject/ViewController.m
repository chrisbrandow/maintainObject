//
//  ViewController.m
//  testMaintainObject
//
//  Created by Chris Personal on 10/16/14.
//  Copyright (c) 2014 Flouu Apps. All rights reserved.
//

#import "ViewController.h"
#import "maintainObject.h"
#import "UILabelModel.h"
#import "axisLabel.h"
#import "sliderModel.h"
#import "radiusSlider.h"
#import "UIViewModel.h"
#import "changingView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) sliderModel *radiusSliderVM;
@property (nonatomic) sliderModel *cornerRadiusSliderVM;
@property (nonatomic) UIViewModel *demoViewModel;

@property (weak, nonatomic) IBOutlet changingView *demoView;
@property (weak, nonatomic) IBOutlet radiusSlider *radiusSlider;
@property (weak, nonatomic) IBOutlet radiusSlider *cornerRadiusSlider;
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
    
    self.radiusSliderVM = [sliderModel new];
    self.cornerRadiusSliderVM = [sliderModel new];
    self.demoViewModel = [UIViewModel new];
    self.crMinLabelVM = [UILabelModel new];
    
    //set demoViewModel properties based on any changes to sliders
    [self.radiusSliderVM whenPropertyChanges:propertyKeyPath(currentValue) updateObject:self.demoViewModel withBlock:^(id dependentObject, id model) {
        [dependentObject setVmRadius:[model currentValue]];
    }];
    
    [self.cornerRadiusSliderVM whenPropertyChanges:propertyKeyPath(currentValue) updateObject:self.demoViewModel withBlock:^(id dependentObject, id model) {
        [dependentObject setVmCornerRadius:[model currentValue]];
    }];
    
    //modify second slider max value so that it is always <= 1/2 of the view's "radius"
    [self.radiusSliderVM whenPropertyChanges:propertyKeyPath(currentValue) updateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        //typecasting allows dot-syntax to be used.
        sliderModel *crVM = (sliderModel *)dependentObject;
        CGFloat newMaxValue = [model currentValue]/2;
        
        crVM.maxValue = (newMaxValue) ?: 1;
        
        if ([dependentObject currentValue] > newMaxValue) {
            crVM.currentValue = (newMaxValue >=1) ? newMaxValue : 1;
        }
        
    }];
    
    [self.radiusSliderVM whenPropertyChanges:propertyKeyPath(currentValue) updateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmBackgroundColor:[UIColor redColor]];
    }];
    
    [self.cornerRadiusSliderVM whenPropertyChanges:propertyKeyPath(maxValue) updateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmTintColor:([model currentValue] >= [model maxValue]) ? [UIColor redColor] : [UIColor blueColor]];
    }];

    [self.cornerRadiusSliderVM whenPropertyChanges:propertyKeyPath(maxValue) updateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        
        NSString *labelString = [NSString stringWithFormat:@"%.0f", ([model maxValue] > 1) ? [model maxValue] : 1];
        [dependentObject setVmText:labelString];

    }];

    [self.radiusSliderVM whenProperty:propertyKeyPath(currentValue) startsOrStopsChanging:changeStop updateBlock:^(id dependentObject, id model) {
        
        self.crMinLabelVM.vmBackgroundColor = [UIColor whiteColor];
        self.cornerRadiusSliderVM.vmTintColor = [UIColor blueColor];

    }];
    [self.radiusSliderVM whenProperty:propertyKeyPath(currentValue) startsOrStopsChanging:changeStart updateBlock:^(id dependentObject, id model) {
        self.radiusSlider.backgroundColor = [UIColor redColor];
        [UIView animateWithDuration:.5 animations:^{
            self.radiusSlider.backgroundColor = [UIColor whiteColor];
        }];
    }];
}

- (IBAction)radiusSliderUpdated:(id)sender {
    UISlider *s = (UISlider *)sender;
    self.radiusSliderVM.currentValue = (s.value) ?: 1;
    
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
    [self.radiusSliderVM property:propertyKeyPath(currentValue) stopOrStartChanging:changeStop];
}

- (IBAction)touchedRadiusSlider:(id)sender {
    [self.radiusSliderVM property:propertyKeyPath(currentValue) stopOrStartChanging:changeStart];
}

@end
