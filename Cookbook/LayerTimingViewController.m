//
//  LayerTimingViewController.m
//  Cookbook
//
//  Created by Stewart Wu on 2014/8/10.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "LayerTimingViewController.h"

@interface LayerTimingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UIView *square;
@property (nonatomic) IBOutlet UITableView *timingTypePicker;
@property (nonatomic) NSArray *timingTypes;

@end

@implementation LayerTimingViewController

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
    
    self.timingTypes = @[kCAMediaTimingFunctionLinear,
                         kCAMediaTimingFunctionEaseIn,
                         kCAMediaTimingFunctionEaseOut,
                         kCAMediaTimingFunctionEaseInEaseOut,
                         kCAMediaTimingFunctionDefault];
    
    self.timingTypePicker.dataSource = self;
    self.timingTypePicker.delegate = self;
}

- (void)dealloc
{
    self.timingTypePicker.delegate = nil;
    self.timingTypePicker.dataSource = nil;
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.timingTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.timingTypes[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];;
    animation.toValue = @(self.square.layer.position.x + 200.0f);
    animation.autoreverses = YES;
    animation.duration = 3.0f;
    // NOTE: Predefined Timing Functions - https://developer.apple.com/library/mac/documentation/Cocoa/Reference/CAMediaTimingFunction_class/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004505-CH1-SW2
    animation.timingFunction=[CAMediaTimingFunction functionWithName:self.timingTypes[indexPath.row]];
    
    [self.square.layer addAnimation:animation forKey:nil];
}

@end
