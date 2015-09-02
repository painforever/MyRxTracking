//
//  SelfAlertsViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AlertFormViewController.h"
#import "AlertCell.h"

@interface SelfAlertsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *add_alert_btn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSMutableArray *table_data;

- (IBAction)add_alert_action:(id)sender;
@end
