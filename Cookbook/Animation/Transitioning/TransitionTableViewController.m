//
//  TransitionTableViewController.m
//  Cookbook
//
//  Created by Ching on 2015/7/29.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "CoverVerticalAnimator.h"
#import "FadeAnimator.h"
#import "ShiftAnimator.h"

#import "SlideshowViewController.h"
#import "PannableViewController.h"

#import "TransitionTableViewController.h"

@interface TransitionTableViewController ()

@property (nonatomic) id<UIViewControllerAnimatedTransitioning> animator;
@property (nonatomic) UIPercentDrivenInteractiveTransition *interactant;

@property (nonatomic) UIImageView *imageView;

@end

@implementation TransitionTableViewController

static NSString * const reuseIdentifier = @"TransitionTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];

    self.animator = [[ShiftAnimator alloc] init];
    self.interactant = [[UIPercentDrivenInteractiveTransition alloc] init];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: // pass-through
        default:
            return @"Modal";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"sample"];
            cell.textLabel.text = @"Fade Animator (Slideshow)";
            break;
        case 1:
            cell.textLabel.text = @"Pannable Interacitve Animator";
            break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIViewController *viewController;

    switch (indexPath.row) {
        case 0:
            viewController = [[SlideshowViewController alloc] initWithImage:cell.imageView.image];
            break;
        case 1:
            viewController = [[PannableViewController alloc] init];
            break;
    }

//    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]
//                                             initWithTarget:self action:@selector(respondToPanGesture:)];

//    viewController.modalPresentationStyle = UIModalPresentationCustom;
//    viewController.transitioningDelegate = viewController;
//    [viewController.view addGestureRecognizer:panRecognizer];

    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - actions

- (IBAction)respondToPanGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint offset = [sender translationInView:self.presentingViewController.view];
    CGFloat progress = offset.y / 200.0;

    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.interactant updateInteractiveTransition:progress];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [self.interactant finishInteractiveTransition];
    } else if (sender.state == UIGestureRecognizerStateCancelled) {
        [self.interactant cancelInteractiveTransition];
    }
}

#pragma mark - public methods

- (UIImageView *)viewForAnimatedTransitioning
{
    return self.imageView;
}

@end
