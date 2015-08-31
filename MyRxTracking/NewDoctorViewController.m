//
//  NewDoctorViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "NewDoctorViewController.h"

@implementation NewDoctorViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"New Doctor";
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.table_data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doctor" forIndexPath:indexPath];
    NSDictionary *cell_data = [self.table_data objectAtIndex: indexPath.row];
    cell.full_name.text = [NSString stringWithFormat:@"%@ %@", cell_data[@"prvd_First_Name"] ,cell_data[@"prvd_Last_Name_Legal_Name"]];
    cell.phone.text = [NSString stringWithFormat:@"%@", cell_data[@"prvd_Business_Practice_loc_addr_Telephone_Number"]];
    cell.npi.text = [NSString stringWithFormat:@"%@", cell_data[@"NPI"]];
    cell.gender.text = [NSString stringWithFormat:@"%@", cell_data[@"prvd_Gender_Code"]];
//    [cell.follow_btn addTarget:self action:@selector(follow_action:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


#pragma UISeaarchbar and Delegates

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *text = searchBar.text;
    //NSMutableArray *search_result_arr = [User searchUsers: text];
    [[AFNetwork getAFManager] GET: [SERVER_URL stringByAppendingString:@"npis/search_doctor"] parameters:@{@"input": text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *search_result_arr = (NSMutableArray *)responseObject;
        self.table_data = search_result_arr;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
}

#pragma segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"doctor_details_segue"]) {
        DoctorDetailsViewController *view = (DoctorDetailsViewController *)segue.destinationViewController;
        view.selected_doctor = [self.table_data objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        NSLog(@"rriiririr: %@", [view.selected_doctor description]);
    }
}
@end
