//
//  VersionViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/31.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "VersionViewController.h"

@interface VersionViewController ()

@property (nonatomic) IBOutlet UILabel *osVersionLabel;
@property (nonatomic) IBOutlet UILabel *deviceTypeLabel;

@end

@implementation VersionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.osVersionLabel.text = [[UIDevice currentDevice] systemVersion];
    self.deviceTypeLabel.text = [[UIDevice currentDevice] model];
}

@end
