//
//  NewDoctorViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorSearchCell.h"
#import "Manifest.h"
#import "DoctorDetailsViewController.h"

@interface NewDoctorViewController : UITableViewController <UISearchBarDelegate,UISearchDisplayDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *table_data;
@property (strong, nonatomic) NSMutableDictionary *selected_doctor;

@end
