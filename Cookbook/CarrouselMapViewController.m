//
//  CarrouselMapViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/13.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

// NOTE: Remember to link to MapKit and CoreLocation Frameworks
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CarrouselMapViewController.h"

@interface CarrouselMapViewController () <MKMapViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSMutableArray *annotations;
@property (nonatomic, weak) MKPointAnnotation *highlightedAnnotation;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation CarrouselMapViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.annotations = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(25.033333 - ((double)(arc4random() % 10) / 1000.0f),
                                                               121.533333 - ((double)(arc4random() % 10) / 1000.0f));
            annotation.title = [NSString stringWithFormat:@"Annotation %d", i];
            [self.annotations addObject:annotation];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // map part
    MKMapRect suitableRect = MKMapRectNull;
    for (MKPointAnnotation *annotation in self.annotations) {
        MKMapPoint point = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect rect = MKMapRectMake(point.x, point.y, 0, 0);
        suitableRect = MKMapRectUnion(rect, suitableRect);
    }
    [self.mapView setVisibleMapRect:suitableRect
                        edgePadding:UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f)
                           animated:YES];
    self.mapView.delegate = self;
    
    // collection part
    static NSString *identifier = @"UICollectionViewCell";
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.highlightedAnnotation = self.annotations[0];
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
    
    static NSString *identifier = @"MKAnnotationView";
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinView) {
        pinView.annotation = annotation;
    } else {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
    }
    if (annotation == self.highlightedAnnotation) {
        pinView.image = [UIImage imageNamed:@"anno-highlighted"];
    } else {
        pinView.image = [UIImage imageNamed:@"anno-normal"];
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
    // map part
    [self.mapView viewForAnnotation:self.highlightedAnnotation].image = [UIImage imageNamed:@"anno-normal"];
    
    self.highlightedAnnotation = (MKPointAnnotation *)[self.annotations objectAtIndex:indexPath.row];
    [self.mapView setCenterCoordinate:self.highlightedAnnotation.coordinate animated:YES];
    
    [self.mapView viewForAnnotation:self.highlightedAnnotation].image = [UIImage imageNamed:@"anno-highlighted"];
    
    // collection part
    static NSString *identifier = @"UICollectionViewCell";
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if ([cell.contentView.subviews count] == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"Annotation %ld", indexPath.row];
        label.textColor = [UIColor blackColor];
        label.frame = CGRectMake(0.0f, 0.0f, 320.0f, 80.0f);
        [cell.contentView addSubview:label];
//        [cell.contentView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"anno-highlighted"]]];
    } else {
        UILabel *label = cell.contentView.subviews[0];
        label.text = [NSString stringWithFormat:@"Annotation %ld", indexPath.row];
    }
    
    return cell;
}

@end
