//
//  RxHistoryTableViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RxDetailsViewController.h"
#import "Manifest.h"

@interface RxHistoryTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) NSMutableArray *table_data;
@property (strong, nonatomic) NSMutableDictionary *rx_row;
@property (strong, nonatomic) RxDetailsViewController *rxDetailsView;
@end
