//
//  FixedPositionViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "FixedPositionViewController.h"

@interface FixedPositionViewController ()

@end

@implementation FixedPositionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger count = 20;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 60.0f;
    
    for (int i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * height, width, height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"Label %d", i + 1];
        label.backgroundColor = [UIColor whiteColor];
        
        if (i == 5) {
            self.fixedPositionView = label;
        }
        
        [self.scrollView addSubview:label];
    }
    
    self.fixedPositionView.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView bringSubviewToFront:self.fixedPositionView];
    
    self.scrollView.contentSize = CGSizeMake(width, height * count);
    
    self.scrollView.delegate = self;
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
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
