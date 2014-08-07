//
//  LayerAnimationViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/8.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "LayerAnimationViewController.h"

@interface LayerAnimationViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) IBOutlet UIView *square;
@property (nonatomic) IBOutlet UIPickerView *animationTypePickter;
@property (nonatomic) NSArray *animationKeys;

@end

@implementation LayerAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.animationKeys = @[@"pick animation type", @"position.x", @"position.y", @"cornerRadius"];
    
    self.animationTypePickter.dataSource = self;
    self.animationTypePickter.delegate = self;
}

- (void)dealloc
{
    self.animationTypePickter.delegate = nil;
    self.animationTypePickter.dataSource = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.animationKeys count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.animationKeys[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:self.animationKeys[row]];
    animation.duration = 0.5f;
    switch (row) {
        case 1:
            animation.fromValue = @(self.square.layer.position.x);
            animation.byValue = @(10.0f);
            self.square.layer.position = CGPointMake(self.square.layer.position.x + 10.0f, self.square.layer.position.y);
            break;
            
        case 2:
            animation.byValue = @(10.0f);
            break;
            
        case 3:
            animation.duration = 1.0f;
            animation.byValue = @(20.0f);
            break;
            
        case 0: // by pass
        default:
            return;
    }
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.square.layer addAnimation:animation forKey:nil];
}

@end
