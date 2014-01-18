//
//  LocationViewController.m
//  Location
//
//  Created by Yan Xia on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"

@implementation LocationViewController
@synthesize longtitude, latitude, horizontalAccuracy, verticalAccuracy, altitude, distance;
@synthesize locationManager, startLocation;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    self.startLocation = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.latitude = nil;
    self.longtitude = nil;
    self.horizontalAccuracy = nil;
    self.verticalAccuracy = nil;
    self.altitude = nil;
    self.distance = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)resetDistance:(id)sender
{
    self.startLocation = nil;
}

#pragma mark - Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.latitude];
    self.latitude.text = currentLatitude;
    
    NSString *currentLongtitude = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.longitude];
    self.longtitude.text = currentLongtitude;
    
    NSString *currentHorizontalAccuracy = [NSString stringWithFormat:@"%g", newLocation.horizontalAccuracy];
    self.horizontalAccuracy.text = currentHorizontalAccuracy;
    
    NSString *currentAltitude = [NSString stringWithFormat:@"%g", newLocation.altitude];
    self.altitude.text = currentAltitude;
    
    NSString *currentVerticalAccuracy = [NSString stringWithFormat:@"%g", newLocation.verticalAccuracy];
    self.verticalAccuracy.text = currentVerticalAccuracy;
    
    if (startLocation == nil) {
        self.startLocation = newLocation;
    }
    CLLocationDistance distanceBetween = [newLocation distanceFromLocation:startLocation];
    NSString *tripString = [NSString stringWithFormat:@"%f", distanceBetween];
    self.distance.text = tripString;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

@end
