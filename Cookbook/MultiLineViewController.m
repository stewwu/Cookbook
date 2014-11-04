//
//  MultiLineViewController.m
//  Cookbook
//
//  Created by Ching on 14.10.14.
//  Copyright (c) 2014 Che-Ching Wu. All rights reserved.
//

#import "MultiLineViewController.h"

@interface MultiLineViewController ()

@end

@implementation MultiLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.inputTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.textLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.textLabel.layer.borderWidth = 1;
    self.textLabel.numberOfLines = 10;
    
    [self changeText:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGSize size = CGSizeMake(self.textLabel.frame.size.width, CGFLOAT_MAX);
    CGRect rect = [self.textLabel.attributedText boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil];
    
    self.calculatedHeightValueLabel.text = [@(rect.size.height) stringValue];
    self.realHeightValueLabel.text = [@(self.textLabel.frame.size.height) stringValue];
}

#pragma mark - Actions

- (void)changeText:(id)sender
{
    NSString *text = @"如果是一般的 NSString 加字體大小的話在 XIB 裡設定即可，但若是 NSAttributedString 而且文字會變動的話，就一定要在程式裡動態產生";
    if (!(self.inputTextField.text && [self.inputTextField.text isEqualToString:@""])) {
        text = self.inputTextField.text;
    }
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 20;
    paragraphStyle.maximumLineHeight = 20;
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: paragraphStyle};
    self.textLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
