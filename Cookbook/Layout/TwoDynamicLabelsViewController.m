//
//  TwoDynamicLabelsViewController.m
//  Cookbook
//
//  Created by Ching on 2015/6/12.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "TwoDynamicLabelsViewController.h"

@interface TwoDynamicLabelsViewController ()

@end

@implementation TwoDynamicLabelsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.label11.text = @"abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz";
    self.label12.text = @"01234567890123456789012345678901234567890123456789";
    [self.label12 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.label21.text = @"abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz";
    [self.label21 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.label22.text = @"01234567890123456789012345678901234567890123456789";
}

@end
