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
#import "cRadiusSlider.h"
#import "radiusSlider.h"
#import "blueViewModel.h"
#import "blueView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) radiusSliderModel *radiusSliderVM;
@property (nonatomic) radiusSliderModel *cornerRadiusSliderVM;
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

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstraint;

@end

@implementation ViewController
- (IBAction)buttonAction:(id)sender {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.radiusSliderVM = [[radiusSliderModel alloc] init];
    self.cornerRadiusSliderVM = [[radiusSliderModel alloc] init];
    self.demoViewModel = [[blueViewModel alloc] init];
    

    [self.demoView configureWithModel:self.demoViewModel];

    [self.radiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
        NSLog(@"hello 1st block");
        [[owner demoViewModel] setVmRadius:100*[model currentValue]];
        [[owner cornerRadiusSliderVM] setMaxValue:100*[model currentValue]/2];
        
    }];
    
    [self.cornerRadiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
        [[owner demoViewModel] setVmCornerRadius:[model currentValue]];
    }];
    

    [self.radiusSlider configureWithModel:self.radiusSliderVM];
    [self.cornerRadiusSlider configureWithModel:self.cornerRadiusSliderVM];
    
    //cbnote: these worked in terms of beign included in the owners map table keys
//    [self.radiusSliderVM withOwner:self maintainWithModel:^(id owner, id model) {
//        NSLog(@"hello 2nd block");
//        [[owner cornerRadiusSliderVM] setMaxValue:[model currentValue]/2];
//    }];
//    
//    [self.radiusSliderVM withOwner:self.cornerRadiusSlider maintainWithModel:^(id owner, id model) {
//        NSLog(@"hello 24th block");
//        [owner setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:[model currentValue] alpha:1]];// setMaxValue:[model currentValue]/2];
//    }];

    


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
    NSLog(@"valval %.1f", s.value);
    self.cornerRadiusSliderVM.currentValue = s.value;


}

- (IBAction)segmentedControllerUpdated:(id)sender {
    
}

@end
