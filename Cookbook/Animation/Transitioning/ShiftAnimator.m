//
//  ShiftAnimator.m
//  Cookbook
//
//  Created by Ching on 2015/8/2.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "ShiftAnimator.h"

@implementation ShiftAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImageView *fromView = [(UIViewController<ShiftAnimatorDataSource> *)((UINavigationController *)fromViewController).topViewController  viewForAnimatedTransitioning];
    UIImageView *toView = [(UIViewController<ShiftAnimatorDataSource> *)toViewController viewForAnimatedTransitioning];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView addSubview:fromView];

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    toView.image = fromView.image;
    toView.alpha = 0.0f;
    [UIView animateWithDuration:duration animations:^{
        fromView.alpha = 0.0f;
        fromView.center = toView.center;
    } completion:^(BOOL finished) {
        toView.alpha = 1.0f;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
