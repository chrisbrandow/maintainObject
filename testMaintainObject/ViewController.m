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
#import "labelVM.h"
#import "axisLabel.h"
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

@property (weak, nonatomic) IBOutlet axisLabel *radiusMaxLabel;

@property (weak, nonatomic) IBOutlet axisLabel *radiusMinLabel;
@property (weak, nonatomic) IBOutlet axisLabel *cornerRadiusMinLabel;
@property (weak, nonatomic) IBOutlet axisLabel *cornerRadiusMaxLabel;

@property (nonatomic) labelVM *crMinLabelVM;


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
    self.crMinLabelVM = [[labelVM alloc] init];
//    labelVM *rMinLabelVM = [[labelVM alloc] init];
    
    
    [self.radiusSliderVM withValueChangeUpdateObject:self.demoViewModel withBlock:^(id dependentObject, id model) {
        [dependentObject setVmRadius:[model currentValue]];
    }];
    
    [self.radiusSliderVM withValueChangeUpdateObject:self.cornerRadiusSliderVM withBlock:^(id dependentObject, id model) {
        radiusSliderModel *crVM = (radiusSliderModel *)dependentObject;

        crVM.maxValue = [model currentValue]/2;

        if ([dependentObject currentValue] > [model currentValue]/2) {
            [dependentObject setValue:@([model currentValue]/2) forKey:propertyKeyPath(currentValue)];
            
        }
    }];
    
    [self.cornerRadiusSliderVM withValueChangeUpdateObject:self withBlock:^(id dependentObject, id model) {
        [[dependentObject demoViewModel] setVmCornerRadius:[model currentValue]];
    }];

    [self.cornerRadiusSliderVM withValueChangeUpdateObject:self.crMinLabelVM withBlock:^(id dependentObject, id model) {
        [dependentObject setVmText:[NSString stringWithFormat:@"%.0f",[model maxValue]] ];
    }];
    
    [self.cornerRadiusMaxLabel configureWithModel:self.crMinLabelVM];
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
//    self.radiusSliderVM.currentValue = s.value;
    [self.radiusSliderVM setValue:@(s.value) forKey:propertyKeyPath(currentValue)];
    
}
- (IBAction)cornerRadiusSliderUpdated:(id)sender {

    UISlider *s = (UISlider *)sender;
//    self.cornerRadiusSliderVM.currentValue = s.value;
    [self.cornerRadiusSliderVM setValue:@(s.value) forKey:propertyKeyPath(currentValue)];
}

- (IBAction)segmentedControllerUpdated:(id)sender {
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    self.demoViewModel.vmColor = self.colors[sc.selectedSegmentIndex];
}

@end
