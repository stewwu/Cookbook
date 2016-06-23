//
//  containerViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/3.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "BasicConstraintViewController.h"

@interface BasicConstraintViewController ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIImageView *image;
@property (nonatomic) UILabel *label;
@property (nonatomic) UIButton *button;

@end

@implementation BasicConstraintViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.containerView];
    
    self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Globe"]];
    [self.image sizeToFit];
    self.image.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.image];
    
    self.label = [[UILabel alloc] init];
    [self.label sizeToFit];
    self.label.text = @"0123456789";
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.label];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button sizeToFit];
    [self.button setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
    self.button.contentEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    self.button.backgroundColor = [UIColor brownColor];
    self.button.layer.borderColor = [UIColor blueColor].CGColor;
    self.button.layer.borderWidth = 2.0f;
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.button];
}

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    NSLog(@"%f", self.topLayoutGuide.length);
//    self.containerView.frame = CGRectMake(0.0f, [[UIScreen mainScreen] applicationFrame].origin.y + self.navigationController.navigationBar.frame.size.height + 90.0f, self.view.frame.size.width, 40.0f);
//}

// VFL: https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage/VisualFormatLanguage.html#//apple_ref/doc/uid/TP40010853-CH3
- (void)updateViewConstraints
{
    // remove old constraints / contraints which IB auto generated at build time for view
    [self.view removeConstraints:self.view.constraints];
    
    CGFloat margin = [[UIScreen mainScreen] applicationFrame].origin.y + self.navigationController.navigationBar.frame.size.height + 10.0f;
    CGFloat padding = (self.view.frame.size.width - self.image.frame.size.width - 10 - self.label.frame.size.width - self.button.frame.size.width) / 2;
    NSDictionary *metrics = @{@"padding": @(padding), @"margin": @(margin)};
    NSDictionary *views = NSDictionaryOfVariableBindings(_image, _label, _button, _containerView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[_image]-10-[_label]-(<=padding)-[_button]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing | NSLayoutFormatAlignAllCenterY
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(margin)-[_containerView(==40)]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];
    
    [super updateViewConstraints];
}

@end
