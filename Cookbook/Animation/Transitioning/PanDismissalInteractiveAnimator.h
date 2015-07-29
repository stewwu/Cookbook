//
//  PanDismissalInteractiveAnimator.h
//  Cookbook
//
//  Created by Ching on 2015/8/15.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PanDismissalInteractiveAnimator : NSObject <UIViewControllerInteractiveTransitioning, UIGestureRecognizerDelegate>

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

- (instancetype)initWithViewController:(UIViewController *)viewController;

@end
