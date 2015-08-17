//
//  SlideshowViewController.h
//  Cookbook
//
//  Created by Ching on 2015/8/2.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideshowViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic) IBOutlet UIImageView *imageView;

- (instancetype)initWithImage:(UIImage *)image;

@end
