//
//  SelfAlertsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SelfAlertsViewController.h"

@implementation SelfAlertsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Alerts";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    //load data
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"reminders"] parameters:@{@"user_id": [userDefaults stringForKey:@"user_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *alerts = (NSMutableArray *)responseObject;
        //NSLog(@"dadasdadsfds: %@", [alerts description]);
        self.table_data = alerts;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        [self showAlert:@"Internet failure" withMessage:@"Your internet access might have problems, please go some other place to try the network here."];
    }];
}
- (IBAction)add_alert_action:(id)sender {
    AlertFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertFormViewController"];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma table view stuffs
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.table_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alert_cell" forIndexPath:indexPath];
    NSDictionary *cell_data = [self.table_data objectAtIndex: indexPath.row];
    cell.reminder_name.text = cell_data[@"reminder_name"];
    cell.drug_name.text = cell_data[@"drug_name"];
    cell.time.text = cell_data[@"reminder_time"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
