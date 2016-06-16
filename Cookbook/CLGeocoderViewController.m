//
//  CLGeocoderViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/12.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

// NOTE: Remember to link to MapKit and CoreLocation Frameworks
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CLGeocoderViewController.h"

@interface CLGeocoderViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIButton *locateButton;
@property (nonatomic, weak) IBOutlet UISlider *radiusSlider;
@property (nonatomic, weak) IBOutlet UITextField *addressTextField;

@end

@implementation CLGeocoderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addressTextField.delegate = self;
    self.addressTextField.returnKeyType = UIReturnKeyGo;
    
    [self.addressTextField addTarget:self
                              action:@selector(locateAddress:)
                    forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.locateButton addTarget:self
                          action:@selector(locateAddress:)
                forControlEvents:UIControlEventTouchUpInside];
    
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.showsUserLocation = YES;
    
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
    
    self.addressTextField.delegate = nil;
    
    [super viewWillDisappear:animated];
}

#pragma mark - Privates

- (void)setMapToCenterCoordinate:(CLLocationCoordinate2D)center
{
    CLLocationDistance meters = self.radiusSlider.value;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, meters, meters);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - Actions

- (void)locateAddress:(id)sender
{
    if ([self.addressTextField isFirstResponder]) {
        [self.addressTextField resignFirstResponder];
    }
    
    if (self.addressTextField.text && ![self.addressTextField.text isEqualToString:@""]) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder geocodeAddressString:self.addressTextField.text
                     completionHandler:^(NSArray* placemarks, NSError* error){
                         if (error) {
                         } else {
                             CLPlacemark *placemark = [placemarks firstObject];
                             MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                             annotation.title = self.addressTextField.text;
                             annotation.coordinate = placemark.location.coordinate;
                             [self.mapView addAnnotation:annotation];
                             [self setMapToCenterCoordinate:placemark.location.coordinate];
                         }
                     }];
        
    } else {
        [self setMapToCenterCoordinate:self.mapView.userLocation.location.coordinate];
    }
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"AnnotationView";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
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

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    
    [self setMapToCenterCoordinate:self.mapView.userLocation.location.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"%@", error);
}

@end
