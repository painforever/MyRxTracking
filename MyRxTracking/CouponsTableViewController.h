//
//  CouponsTableViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponCell.h"
#import "Coupon.h"
#import "SWRevealViewController.h"

@interface CouponsTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *table_data;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
