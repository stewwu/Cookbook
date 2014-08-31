//
//  ScreenViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/31.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "ScreenViewController.h"

@interface ScreenViewController ()

@property (nonatomic) IBOutlet UILabel *screenSizeLabel;
@property (nonatomic) IBOutlet UILabel *screenBoundsLabel;
@property (nonatomic) IBOutlet UILabel *screenAppFrameLabel;

@end

@implementation ScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScreenMode *screenMode = [[UIScreen mainScreen] currentMode];
    self.screenSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)screenMode.size.height, (int)screenMode.size.width];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.screenBoundsLabel.text = [NSString stringWithFormat:@"%dx%d", (int)screenRect.size.height, (int)screenRect.size.width];
    CGRect appFrameRect = [[UIScreen mainScreen] applicationFrame];
    self.screenBoundsLabel.text = [NSString stringWithFormat:@"%dx%d", (int)appFrameRect.size.height, (int)appFrameRect.size.width];
}

@end
