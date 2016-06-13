//
//  FloatingTextInputViewController.m
//  Cookbook
//
//  Created by Stewart Wu on 2016/6/13.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "FloatingTextInputViewController.h"

@interface FloatingTextInputViewController ()

@property (nonatomic, weak) IBOutlet UIButton *toggleButton;
@property (nonatomic, weak) IBOutlet UIView *submitView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIButton *submitButton;

@end

@implementation FloatingTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.submitView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSubmitViewFrame:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGRect submitViewFrame = self.view.frame;
    submitViewFrame.origin = CGPointMake(0, self.view.frame.size.height);
    submitViewFrame.size.height = 40;
    self.submitView.frame = submitViewFrame;
}

- (IBAction)showSubmitView:(id)sender {
    [self.textField becomeFirstResponder];
}

- (void)updateSubmitViewFrame:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect submitViewFrame = self.submitView.frame;
    submitViewFrame.origin.y = keyboardFrame.origin.y - self.submitView.frame.size.height;
    self.submitView.frame = submitViewFrame;
}

@end
