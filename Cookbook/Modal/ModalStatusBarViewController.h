//
//  ModalNoStatusBarViewController.h
//  Cookbook
//
//  Created by Ching on 2015/6/11.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalStatusBarViewController : UIViewController

@property (nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic) IBOutlet UILabel *frameLabel;
@property (nonatomic) IBOutlet UILabel *closeButtonFrameLabel;

- (instancetype)initWithStatusBarHidden:(BOOL)hidden overlapped:(BOOL)hidden;

@end
