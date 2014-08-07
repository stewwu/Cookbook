//
//  FixedPositionViewController.h
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FixedPositionViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIView *fixedPositionView;

@end
