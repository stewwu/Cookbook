//
//  FixedPositionViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "FixedPositionViewController.h"

@interface FixedPositionViewController ()

@property (nonatomic) NSInteger count;

@end

@implementation FixedPositionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.count = 20;
    
    for (int i = 0; i < self.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"Label %d", i + 1];
        label.backgroundColor = [UIColor whiteColor];
        label.tag = i;
        [self.scrollView addSubview:label];

        if (i == 5) {
            self.fixedPositionView = label;
            self.fixedPositionView.backgroundColor = [UIColor lightGrayColor];
            [self.scrollView bringSubviewToFront:self.fixedPositionView];
        }
    }

    self.scrollView.delegate = self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    CGFloat width = self.view.frame.size.width;
    CGFloat height = 60.0f;

    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.frame = CGRectMake(0, label.tag * height, width, height);
        }
    }

    self.scrollView.contentSize = CGSizeMake(width, height * self.count);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat topMargin = [[UIScreen mainScreen] applicationFrame].origin.y + self.navigationController.navigationBar.frame.size.height;
    CGRect frame = self.fixedPositionView.frame;
    if ((scrollView.contentOffset.y + topMargin) > 60 * 5) {
        frame.origin.y = scrollView.contentOffset.y + topMargin;
    } else {
        frame.origin.y = 60 * 5;
    }
    self.fixedPositionView.frame = frame;
}

@end
