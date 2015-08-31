//
//  DoctorDetailsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/31/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "DoctorDetailsViewController.h"

@interface DoctorDetailsViewController ()

@end

@implementation DoctorDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gender.text = @"M";
    self.address.text = self.selected_doctor[@"prvd_First_Line_Business_Practice_loc_addr"];
    self.full_name.text = [NSString stringWithFormat:@"%@ %@", self.selected_doctor[@"prvd_First_Name"], self.selected_doctor[@"prvd_Last_Name_Legal_Name"]];
    
    NSString *location = self.address.text;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         MKCoordinateRegion region = self.mapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 1200.0;
                         region.span.latitudeDelta /= 1200.0;
                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:placemark];
                         
                     }
                 }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)add_btn_action:(id)sender {
}
@end
