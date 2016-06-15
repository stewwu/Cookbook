//
//  OverlayPresentationController.m
//  Cookbook
//
//  Created by Ching on 2016/6/14.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "OverlayPresentationController.h"

@interface OverlayPresentationController ()

@property (nonatomic) UIView *positionView;

@end

@implementation OverlayPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        self.positionView = [[UIView alloc] init];
    }
    return self;
}

- (UIView *)presentedView {
    return self.positionView;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect containerBounds = self.containerView.bounds;
    CGRect presentedViewFrame = containerBounds;

    presentedViewFrame.size.height = floorf(containerBounds.size.height / 2.0);
    presentedViewFrame.origin.y += presentedViewFrame.size.height;
    return presentedViewFrame;
}

- (void)presentationTransitionWillBegin {
    UIViewController* presentedViewController = [self presentedViewController];

    self.positionView.frame = self.frameOfPresentedViewInContainerView;
    presentedViewController.view.frame = self.positionView.bounds;
    [self.positionView addSubview:presentedViewController.view];

    if (presentedViewController.transitionCoordinator) {
        self.containerView.backgroundColor = [UIColor clearColor];
        [presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        } completion:nil];
    } else {
        self.containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        self.containerView.backgroundColor = [UIColor clearColor];
    }
}

- (void)dismissalTransitionWillBegin {
    UIViewController* presentedViewController = [self presentedViewController];

    if (presentedViewController.transitionCoordinator) {
        [presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.containerView.backgroundColor = [UIColor clearColor];
        } completion:nil];
    } else {
        self.containerView.backgroundColor = [UIColor clearColor];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        self.containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
}

@end
