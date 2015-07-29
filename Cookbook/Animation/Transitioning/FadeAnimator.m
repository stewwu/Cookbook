//
//  FadeAnimator.m
//  Cookbook
//
//  Created by Ching on 2015/7/30.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "FadeAnimator.h"

@implementation FadeAnimator

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

    if (self.presenting) {
        [containerView addSubview:fromViewController.view];
        [containerView addSubview:toViewController.view];

        toViewController.view.alpha = 0;
        [UIView animateWithDuration:duration animations:^{
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    } else {
        [containerView addSubview:toViewController.view];
        [containerView addSubview:fromViewController.view];

        fromViewController.view.alpha = 1;
        [UIView animateWithDuration:duration animations:^{
            fromViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end
