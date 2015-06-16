//
//  LabelCollectionViewCell.h
//  Cookbook
//
//  Created by Ching on 2015/6/15.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCollectionViewCell : UICollectionViewCell

@property (nonatomic) IBOutlet UILabel *label;
@property (nonatomic) IBOutlet NSLayoutConstraint *labelWidthConstraint;

@end
