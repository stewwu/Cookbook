//
//  MapByAnnotationsViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/12.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

// NOTE: Remember to link to MapKit and CoreLocation Frameworks
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MapByAnnotationsViewController.h"

@interface MapByAnnotationsViewController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic) NSMutableArray *annotations;

@end

@implementation MapByAnnotationsViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.annotations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
}

- (void)dealloc
{
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = nil;
}

#pragma mark - MKMapViewDelegate

// 25.033333
// 121.533333
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if ([self.annotations count] > 0) {
        [mapView removeAnnotations:self.annotations];
        [self.annotations removeAllObjects];
    }
    
    for (int i = 0; i < 10; i++) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(mapView.userLocation.coordinate.latitude - ((double)(arc4random() % 10) / 1000.0f), mapView.userLocation.coordinate.longitude - ((double)(arc4random() % 10) / 1000.0f));
        [self.annotations addObject:annotation];
        
    }
    
    MKMapRect suitableRect = MKMapRectNull;
    for (MKPointAnnotation *annotation in self.annotations) {
        MKMapPoint point = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect rect = MKMapRectMake(point.x, point.y, 0, 0);
        suitableRect = MKMapRectUnion(rect, suitableRect);
    }

    [mapView setVisibleMapRect:suitableRect edgePadding:UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f) animated:YES];
}

//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    [mapView addAnnotations:self.annotations];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"AnnotationView";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinView) {
        pinView.annotation = annotation;
    } else {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
    }
    
    return pinView;
}

@end
