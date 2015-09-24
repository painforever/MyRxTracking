//
//  RxDetailsTableViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/24/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetwork.h"

@interface RxDetailsTableViewController : UITableViewController
//@property (strong, nonatomic) NSString *rx_item_id;
@property (strong, nonatomic) NSDictionary *data;

@property (strong, nonatomic) NSString *drug_name;
@property (strong, nonatomic) NSString *drug_photo;
@property (strong, nonatomic) NSString *rx_id;
@property (strong, nonatomic) NSString *dosage;

@property (strong, nonatomic) NSString *days_of_treatment;
@property (strong, nonatomic) NSString *times_per_day;
@property (strong, nonatomic) NSString *notes;
@end
