//
//  PannableViewController.m
//  Cookbook
//
//  Created by Ching on 2015/8/15.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "CoverVerticalAnimator.h"
#import "PanDismissalInteractiveAnimator.h"

#import "PannableViewController.h"

static NSString * const reuseIdentifier = @"Cell";

@interface PannableViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic) CoverVerticalAnimator *animator;
@property (nonatomic) PanDismissalInteractiveAnimator *interactiveAnimator;

@end

@implementation PannableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    self.animator = [[CoverVerticalAnimator alloc] init];
    self.interactiveAnimator = [[PanDismissalInteractiveAnimator alloc] initWithViewController:self];
    self.transitioningDelegate = self;
}

- (IBAction)dismiss:(id)sender
{
    self.interactiveAnimator = nil;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.animator.presenting = YES;
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.presenting = NO;
    return self.animator;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveAnimator;
}

@end
