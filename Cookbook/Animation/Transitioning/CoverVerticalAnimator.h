//
//  CoverVerticalAnimator.h
//  Cookbook
//
//  Created by Ching on 2015/7/29.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoverVerticalAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, getter=isPresenting) BOOL presenting;

@end
