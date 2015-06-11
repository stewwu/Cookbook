//
//  ModalContainerViewController.m
//  Cookbook
//
//  Created by Ching on 2015/6/11.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "ModalContainerViewController.h"

@interface ModalContainerViewController ()

@property (nonatomic) UIViewController *childViewController;

@end

@implementation ModalContainerViewController

- (instancetype)initWithChildViewController:(UIViewController *)childViewController
{
    if ((self = [super init])) {
        _childViewController = childViewController;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewController:self.childViewController];
    CGRect frame = self.view.frame;
    frame.origin.y += 20;
    self.childViewController.view.frame = frame;
    [self.childViewController didMoveToParentViewController:self];
    [self.view addSubview:self.childViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
