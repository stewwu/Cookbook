//
//  LabelCollectionViewCell.m
//  Cookbook
//
//  Created by Ching on 2015/6/15.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@implementation LabelCollectionViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // for iOS 7
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
