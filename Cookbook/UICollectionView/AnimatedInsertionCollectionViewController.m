//
//  AnimatedInsertionCollectionViewController.m
//  Cookbook
//
//  Created by Ching on 2016/5/23.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "AnimatedInsertionCollectionViewController.h"

@interface AnimatedInsertionCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) NSInteger itemsCountToInsert;

@end

@implementation AnimatedInsertionCollectionViewFlowLayout

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];

    if (itemIndexPath.item < self.itemsCountToInsert) {
        CGRect frame = attr.frame;
        frame.origin.y = (-100 - 10) * (self.itemsCountToInsert - itemIndexPath.item);
        attr.frame = frame;
    }

    return attr;
}

@end


@interface AnimatedInsertionCollectionViewController ()

@property (nonatomic) AnimatedInsertionCollectionViewFlowLayout *flowLayout;
@property (nonatomic) NSMutableArray *dataSource;

@end

@implementation AnimatedInsertionCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    return [super initWithNibName:NSStringFromClass(self.class) bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    self.flowLayout = [[AnimatedInsertionCollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = self.flowLayout;

    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        [self.dataSource addObject:@(i)];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataSource insertObject:@(0) atIndex:0];
        [self.dataSource insertObject:@(1) atIndex:1];
        [self.dataSource insertObject:@(2) atIndex:2];
        self.flowLayout.itemsCountToInsert = 3;
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0], [NSIndexPath indexPathForItem:1 inSection:0], [NSIndexPath indexPathForItem:2 inSection:0]]];
    });
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:[(NSNumber *)self.dataSource[indexPath.item] integerValue] * 0.1 alpha:1];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.bounds.size.width, 100);
}

@end
