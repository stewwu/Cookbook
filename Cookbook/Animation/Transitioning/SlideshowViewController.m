//
//  SlideshowViewController.m
//  Cookbook
//
//  Created by Ching on 2015/8/2.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "CoverVerticalAnimator.h"
#import "FadeAnimator.h"
#import "SlideshowViewController.h"

@interface SlideshowViewController ()

@property (nonatomic, copy) UIImage *image;

@property (nonatomic) FadeAnimator *animator;

@end

@implementation SlideshowViewController

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
//        self.image = image;
        self.animator = [[FadeAnimator alloc] init];
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = self.view.frame;
    frame.size.width = CGRectGetWidth([UIScreen mainScreen].applicationFrame);
    self.imageView.image = self.image;
}

#pragma mark - actions

- (IBAction)dismiss
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.animator.presenting = YES;
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.presenting = NO;
    return self.animator;
}

@end
