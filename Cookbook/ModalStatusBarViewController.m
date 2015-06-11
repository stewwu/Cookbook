//
//  ModalNoStatusBarViewController.m
//  Cookbook
//
//  Created by Ching on 2015/6/11.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "ModalStatusBarViewController.h"

@interface ModalStatusBarViewController ()

@property (nonatomic) BOOL hidesStatusBar;
@property (nonatomic) BOOL overlapsStatusBar;

@end

@implementation ModalStatusBarViewController

- (instancetype)initWithStatusBarHidden:(BOOL)hidden overlapped:(BOOL)overlapped
{
    if ((self = [super init])) {
        _hidesStatusBar = hidden;
        _overlapsStatusBar = overlapped;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.frameLabel.text = [NSString stringWithFormat:@"x: %.f, y: %.f, width: %.f, height: %.f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height];
    self.closeButtonFrameLabel.text = [NSString stringWithFormat:@"x: %.f, y: %.f, width: %.f, height: %.f", self.closeButton.frame.origin.x, self.closeButton.frame.origin.y, self.closeButton.frame.size.width, self.closeButton.frame.size.height];
}

- (IBAction)dissmissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return self.hidesStatusBar;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationNone;
}

@end
