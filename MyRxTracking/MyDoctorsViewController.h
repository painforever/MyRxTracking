//
//  MyDoctorsViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "NewDoctorViewController.h"
#import "DoctorCell.h"
#import "DoctorDetailsViewController.h"

@interface MyDoctorsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *add_new_doctor;
@property (strong, nonatomic) NSMutableArray *table_data;

//- (IBAction)add_new_doctor_action:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
