//
//  DoctorDetailsViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/31/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DoctorDetailsViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *full_name;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *gender;

@property (strong, nonatomic) IBOutlet UIButton *add_btn;
@property (nonatomic) NSMutableDictionary *selected_doctor;
- (IBAction)add_btn_action:(id)sender;

@end
