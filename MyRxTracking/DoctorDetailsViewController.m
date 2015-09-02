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
    self.gender.text = [NSString stringWithFormat:@"Gender: %@", @"M"];
    self.address.text = [NSString stringWithFormat:@"Address: %@", self.selected_doctor[@"prvd_First_Line_Business_Practice_loc_addr"]];
    self.full_name.text = [NSString stringWithFormat:@"Full name: %@ %@", self.selected_doctor[@"prvd_First_Name"], self.selected_doctor[@"prvd_Last_Name_Legal_Name"]];
    
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

- (IBAction)add_btn_action:(id)sender {
    NSDictionary *params = [PatientProviderAssignment constructParams: [userDefaults stringForKey:@"patient_id"] withProviderNPI: self.selected_doctor[@"NPI"]];
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"patient_provider_assignments"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Add doctor success" withMessage:@"Doctor added!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}
@end
