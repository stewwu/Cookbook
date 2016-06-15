//
//  CustomizedPresentationViewController.m
//  Cookbook
//
//  Created by Ching on 2016/6/14.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "OverlayPresentationController.h"
#import "CustomizedPresentationViewController.h"

@interface CustomizedPresentationViewController () <UIViewControllerTransitioningDelegate, UIPopoverPresentationControllerDelegate>

@end

@implementation CustomizedPresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)presentInFullScreenStyle:(id)sender {
    CustomizedPresentationViewController *viewController = [[CustomizedPresentationViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)presentInOverFullScreenStyle:(id)sender {
    CustomizedPresentationViewController *viewController = [[CustomizedPresentationViewController alloc] init];
    viewController.view.alpha = 0.5;
    viewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)presentInPopoverStyle:(id)sender {
    CustomizedPresentationViewController *viewController = [[CustomizedPresentationViewController alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationPopover;
    UIButton *button = (UIButton *)sender;
    viewController.popoverPresentationController.sourceView = button;
    viewController.popoverPresentationController.sourceRect = button.frame;
    viewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        viewController.popoverPresentationController.delegate = self;
    }
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)presentByOverlayPresentationControler:(id)sender {
    CustomizedPresentationViewController *viewController = [[CustomizedPresentationViewController alloc] init];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)presentAlertController:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                             message:@"This is an alert."
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Present"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          CustomizedPresentationViewController *viewController = [[CustomizedPresentationViewController alloc] init];
                                                          [self presentViewController:viewController animated:YES completion:nil];
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    OverlayPresentationController *presentationController = [[OverlayPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentationController;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
