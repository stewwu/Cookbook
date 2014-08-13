//
//  WhereAmIViewController.m
//  Cookbook
//
//  Created by Stewart Wu on 2014/8/10.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

// NOTE: Remember to link to MapKit and CoreLocation Frameworks
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "WhereAmIViewController.h"

@interface WhereAmIViewController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) MKMapView *mapView;

@end

@implementation WhereAmIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        // NOTE: For better battery performance
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.locationManager.distanceFilter = 500; // meters
        [self.locationManager startUpdatingLocation];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
    }
    
    [super viewWillDisappear:animated];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"%@", error);
}

@end
