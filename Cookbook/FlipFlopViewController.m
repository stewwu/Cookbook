//
//  FlipFlopViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/22.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "FlipFlopViewController.h"

typedef NS_ENUM(NSUInteger, CCFlipViewStyle) {
    CCFlipViewMapStyle = 0,
    CCFlipViewListStyle
};

@interface FlipFlopViewController () <MKMapViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) CCFlipViewStyle viewStyle;
@property (nonatomic) UIBarButtonItem *mapBarButtonItem;
@property (nonatomic) UIBarButtonItem *listBarButtonItem;
@property (nonatomic) NSMutableArray *annotations;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation FlipFlopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.annotations = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(25.033333 - ((double)(arc4random() % 10) / 1000.0f),
                                                               121.533333 - ((double)(arc4random() % 10) / 1000.0f));
            annotation.title = [NSString stringWithFormat:@"Annotation %d", i];
            [self.annotations addObject:annotation];
        }
        self.viewStyle = CCFlipViewMapStyle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation part
    self.mapBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"map"] style:UIBarButtonItemStylePlain target:self action:@selector(flipView)];
    self.listBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list"] style:UIBarButtonItemStylePlain target:self action:@selector(flipView)];
    self.navigationItem.rightBarButtonItem = self.listBarButtonItem;
    
    // map part
    self.mapView.delegate = self;
    
    // collection part
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
    self.collectionView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MKMapRect suitableRect = MKMapRectNull;
    for (MKPointAnnotation *annotation in self.annotations) {
        MKMapPoint point = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect rect = MKMapRectMake(point.x, point.y, 0, 0);
        suitableRect = MKMapRectUnion(rect, suitableRect);
    }
    [self.mapView setVisibleMapRect:suitableRect
                        edgePadding:UIEdgeInsetsMake([UIScreen mainScreen].applicationFrame.origin.y + self.navigationController.navigationBar.frame.size.height + 50.0f, 50.0f, 50.0f, 50.0f)
                           animated:YES];
    
    [self.mapView addAnnotations:self.annotations];
}

- (void)dealloc
{
    self.collectionView.dataSource = nil;
    
    self.mapView.delegate = nil;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"MKPinAnnotationView";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinView) {
        pinView.annotation = annotation;
    } else {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = NO;
    }
    
    return pinView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.annotations count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if ([cell.contentView.subviews count] == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"Annotation %ld", indexPath.item];
        label.textColor = [UIColor blackColor];
        label.frame = CGRectMake(0.0f, 0.0f, 320.0f, 80.0f);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    } else {
        UILabel *label = cell.contentView.subviews[0];
        label.text = [NSString stringWithFormat:@"Annotation %ld", indexPath.item];
    }
    
    return cell;
}

#pragma mark - Actions

- (void)flipView
{
    if (self.viewStyle == CCFlipViewMapStyle) {
        [UIView transitionFromView:self.mapView
                            toView:self.collectionView
                          duration:0.3f
                           options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            self.viewStyle = CCFlipViewListStyle;
                        }];
        self.navigationItem.rightBarButtonItem = self.mapBarButtonItem;
    } else {
        [UIView transitionFromView:self.collectionView
                            toView:self.mapView
                          duration:0.3f
                           options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            self.viewStyle = CCFlipViewMapStyle;
                        }];
        self.navigationItem.rightBarButtonItem = self.listBarButtonItem;
    }
}

@end
