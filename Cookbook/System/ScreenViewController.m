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
@property (nonatomic) IBOutlet UILabel *screenNativeBoundsLabel;
@property (nonatomic) IBOutlet UILabel *screenScaleLabel;
@property (nonatomic) IBOutlet UILabel *screenNativeScaleLabel;
@property (nonatomic) IBOutlet UILabel *screenAppFrameLabel;

@end

@implementation ScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScreenMode *screenMode = [[UIScreen mainScreen] currentMode];
    self.screenSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)screenMode.size.height, (int)screenMode.size.width];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.screenBoundsLabel.text = [NSString stringWithFormat:@"%dx%d", (int)bounds.size.height, (int)bounds.size.width];
    CGRect nativeBounds = [[UIScreen mainScreen] nativeBounds];
    self.screenNativeBoundsLabel.text = [NSString stringWithFormat:@"%dx%d", (int)nativeBounds.size.height, (int)nativeBounds.size.width];
    NSInteger scale = [[UIScreen mainScreen] scale];
    self.screenScaleLabel.text = [NSString stringWithFormat:@"%zd", scale];
    NSInteger nativeScale = [[UIScreen mainScreen] nativeScale];
    self.screenNativeScaleLabel.text = [NSString stringWithFormat:@"%zd", nativeScale];
    CGRect appFrameRect = [[UIScreen mainScreen] applicationFrame];
    self.screenAppFrameLabel.text = [NSString stringWithFormat:@"%dx%d", (int)appFrameRect.size.height, (int)appFrameRect.size.width];
}

@end
