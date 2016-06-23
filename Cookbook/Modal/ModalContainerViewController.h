//
//  ModalContainerViewController.h
//  Cookbook
//
//  Created by Ching on 2015/6/11.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

// http://stackoverflow.com/questions/12741224/ios-modal-viewcontroller-with-transparent-background
@interface ModalContainerViewController : UIViewController

- (instancetype)initWithChildViewController:(UIViewController *)childViewController;

@end
