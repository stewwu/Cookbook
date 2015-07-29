//
//  FadeAnimator.h
//  Cookbook
//
//  Created by Ching on 2015/7/30.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FadeAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter=isPresenting) BOOL presenting;

@end
