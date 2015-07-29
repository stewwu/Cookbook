//
//  ShiftAnimator.h
//  Cookbook
//
//  Created by Ching on 2015/8/2.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShiftAnimatorDataSource <NSObject>

- (UIImageView *)viewForAnimatedTransitioning;

@end


@interface ShiftAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end
