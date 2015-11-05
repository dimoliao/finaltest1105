//
//  MapViewController.m
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "CoffeeDetailViewController.h"
@interface MapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    BOOL isFirstGetLocation;
    CLGeocoder *geoCoder;
    __weak IBOutlet MKMapView *myMapView;
    CLLocationCoordinate2D coordinateCoffee;
    NSString *coffee;
    __block CLPlacemark *placeMark;
    
}

@end

@implementation MapViewController

-(void)addAnnotation {
    coordinateCoffee = CLLocationCoordinate2DMake(placeMark.location.coordinate.latitude,placeMark.location.coordinate.longitude);
    MyAnnotation *annotation = [[MyAnnotation alloc]
                                initWithCoordinate:coordinateCoffee
                                title:self.nameOfCoffee subtitle:self.addressOfCoffee];
    [myMapView addAnnotation:annotation];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstGetLocation = NO;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    

    // Do any additional setup after loading the view.
    geoCoder = [[CLGeocoder alloc] init];
    [self getCoordinateFromAddress];

    
  //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"userLocation %@", userLocation);
    
    
    if(isFirstGetLocation == NO) {
        isFirstGetLocation = YES;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 1000, 1000 );
        [mapView setRegion:region animated:YES];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *annoView;
    if([annotation isKindOfClass:[MyAnnotation class]]) {
        
        annoView = (MKPinAnnotationView*)[myMapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
        if(annoView == nil) {
            
            annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
            annoView.pinTintColor = [MKPinAnnotationView purplePinColor];
            annoView.canShowCallout = YES;
            annoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annoView.draggable = YES;
            
        }
    }
    
    return annoView;
    
}


-(void)getCoordinateFromAddress {
    coffee = self.addressOfCoffee;
    [geoCoder geocodeAddressString:coffee
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if(error == nil && placemarks.count > 0)
                     {
                         placeMark = placemarks[0];
                         NSLog(@"location %@", placeMark.location);
                         [self addAnnotation];
                     }
                 }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
