//
//  TextViewCollectionViewController.m
//  Cookbook
//
//  Created by Stewart Wu on 2016/5/23.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "TextViewCollectionViewCell.h"
#import "TextViewCollectionViewController.h"

@interface TextViewCollectionViewController () <UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@end

@implementation TextViewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"TextViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    self.textView = cell.textView;
    self.textView.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 5 + 8 + 15 + 8 + 5;
    return CGSizeMake(self.collectionView.bounds.size.width, (self.textView) ? (5 + self.textView.frame.size.height + 5) : height);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat width = textView.frame.size.width;
    CGSize size = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGRect frame = textView.frame;
    frame.size = CGSizeMake(fmaxf(size.width, width), size.height);
    textView.frame = frame;

//    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    [self.collectionViewLayout invalidateLayout];
}

@end
