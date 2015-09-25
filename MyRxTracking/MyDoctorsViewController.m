
//
//  MyDoctorsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "MyDoctorsViewController.h"

@implementation MyDoctorsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Doctors";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"patient_provider_assignments"] parameters:@{@"patient_id": [userDefaults stringForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.table_data = (NSMutableArray *)responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        NSLog(@"failed");
    }];
}

//- (IBAction)add_new_doctor_action:(id)sender {
//    NewDoctorViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDoctorViewController"];
//    [self.navigationController pushViewController:view animated:YES];
//}

#pragma table view stuffs
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.table_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doctor_cell" forIndexPath:indexPath];
    NSDictionary *cell_data = [self.table_data objectAtIndex: indexPath.row];
    
    cell.name.text = [NSString stringWithFormat:@"%@ %@", cell_data[@"prvd_First_Name"] ,cell_data[@"prvd_Last_Name_Legal_Name"]];
    cell.phone.text = [NSString stringWithFormat:@"Phone: %@", cell_data[@"prvd_Business_Practice_loc_addr_Telephone_Number"]];
    cell.address.text = [NSString stringWithFormat:@"Address %@", cell_data[@"prvd_First_Line_Business_Practice_loc_addr"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorDetailsViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"DoctorDetailsViewController"];
    NSMutableDictionary *selected_data = [self.table_data objectAtIndex: indexPath.row];
    view.selected_doctor = selected_data;
    [self.navigationController pushViewController:view animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
