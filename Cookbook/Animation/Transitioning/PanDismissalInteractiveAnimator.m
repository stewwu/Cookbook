//
//  PanDismissalInteractiveAnimator.m
//  Cookbook
//
//  Created by Ching on 2015/8/15.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "PanDismissalInteractiveAnimator.h"

static CGFloat const dismissmalPanDistanceMin = 200.0f;

@interface PanDismissalInteractiveAnimator ()

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> context;

@end

@implementation PanDismissalInteractiveAnimator

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
        self.panGestureRecognizer.delegate = self;
        [viewController.view addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

#pragma mark UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.context = transitionContext;

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [[transitionContext containerView] addSubview:toViewController.view];
    [[transitionContext containerView] addSubview:fromViewController.view];

    toViewController.view.alpha = 0.5;
}

#pragma mark - privates

- (void)updateInteractiveTransition:(CGPoint)translation
{
    UIViewController *fromViewController = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];

    toViewController.view.alpha = 1.0 - 0.5 * (fminf(dismissmalPanDistanceMin, fabs(translation.y)) / dismissmalPanDistanceMin);
    CGRect frame = [self.context initialFrameForViewController:fromViewController];
    frame.origin.y += ceilf(translation.y);
    fromViewController.view.frame = frame;
}

- (void)finishInteractiveTransition
{
    UIViewController *fromViewController = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];

    CGRect toFrame = fromViewController.view.frame;
    toFrame.origin.y = (CGRectGetMinY(toFrame) > 0) ? CGRectGetHeight(toFrame) : -CGRectGetHeight(toFrame);
    [UIView animateWithDuration:0.25 animations:^{
        toViewController.view.alpha = 1.0;
        fromViewController.view.frame = toFrame;
    } completion:^(BOOL finished) {
        [self.context completeTransition:YES];
        [self.viewController.view removeGestureRecognizer:self.panGestureRecognizer];
    }];
}

- (void)cancelInteractiveTransition
{
    UIViewController *fromViewController = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];

    CGRect toFrame = [self.context initialFrameForViewController:fromViewController];
    [UIView animateWithDuration:0.25 animations:^{
        toViewController.view.alpha = 0.5;
        fromViewController.view.frame = toFrame;
    } completion:^(BOOL finished) {
        [self.context completeTransition:NO];
        toViewController.view.alpha = 1.0;
    }];

}

#pragma mark - actions

- (void)onPan:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [self.panGestureRecognizer translationInView:nil];

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self updateInteractiveTransition:translation];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (fabs(translation.y) >= dismissmalPanDistanceMin) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
    } else if (gestureRecognizer.state >= UIGestureRecognizerStateCancelled) {
        [self cancelInteractiveTransition];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [self.panGestureRecognizer translationInView:nil];

    UIView *view = gestureRecognizer.view;
    UIView *subview = [view hitTest:[gestureRecognizer locationInView:view] withEvent:nil];
    while (subview) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subview;
            if (scrollView.contentOffset.y == 0 && translation.y < 0) {
                return NO;
            }
            if ((scrollView.contentOffset.y + CGRectGetHeight(scrollView.frame)) >= scrollView.contentSize.height && translation.y > 0) {
                return NO;
            }
        }
        subview = subview.superview;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

@end
