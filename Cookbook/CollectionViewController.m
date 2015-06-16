//
//  CollectionViewController.m
//  Cookbook
//
//  Created by Ching on 2015/6/12.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "LabelCollectionViewCell.h"

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const sampleString = @"The quick brown fox jumps over a lazy dog. ";
static const CGFloat labelInset = 10.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    [self populateVariableHeightContentInCell:cell atIndexPath:indexPath];
    cell.label.textColor = [UIColor orangeColor];
    CGFloat color = 1.0 / (indexPath.row + 1.0);
    cell.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1.0];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCollectionViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCollectionViewCell" owner:self options:nil] lastObject];

    [self populateVariableHeightContentInCell:cell atIndexPath:indexPath];

    cell.labelWidthConstraint.constant = collectionView.bounds.size.width - 2 * labelInset;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size;
}

#pragma mark - privates

- (void)populateVariableHeightContentInCell:(LabelCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSMutableString *s = [NSMutableString string];
    for (int i = 0; i <= indexPath.item; i++) {
        [s appendString:sampleString];
    }
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 10.0f;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    cell.label.attributedText = [[NSAttributedString alloc] initWithString:s attributes:@{NSParagraphStyleAttributeName: style, NSFontAttributeName: font}];
}

@end
