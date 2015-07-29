//
//  CoverVerticalAnimator.m
//  Cookbook
//
//  Created by Ching on 2015/7/29.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "CoverVerticalAnimator.h"

@implementation CoverVerticalAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    if (self.isPresenting) {
        [containerView addSubview:toViewController.view];
//        CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
        CGRect toFrame = fromViewController.view.frame;
        CGRect fromFrame = CGRectMake(0, CGRectGetHeight(toFrame), CGRectGetWidth(toFrame), CGRectGetHeight(toFrame));
        toViewController.view.frame = fromFrame;
        [UIView animateWithDuration:duration animations:^{
            toViewController.view.frame = toFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    } else {
        [containerView addSubview:toViewController.view];
        [containerView addSubview:fromViewController.view];
//        CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
        CGRect fromFrame = fromViewController.view.frame;
        CGRect toFrame = CGRectMake(0, CGRectGetHeight(fromFrame), CGRectGetWidth(fromFrame), CGRectGetHeight(fromFrame));
        fromViewController.view.frame = fromFrame;
        [UIView animateWithDuration:duration animations:^{
            fromViewController.view.frame = toFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end
