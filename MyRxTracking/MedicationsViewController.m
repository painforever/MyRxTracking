
//
//  MedicationsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "MedicationsViewController.h"
#import "AFNetwork.h"
#import "Constants.h"
#import "DrugCell.h"

@implementation MedicationsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Medications";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.table_data = (NSMutableArray *)responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        NSLog(@"failed");
    }];
}
- (IBAction)add_med_action:(id)sender {
    NewMedFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMedFormViewController"];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.table_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DrugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drug_cell" forIndexPath:indexPath];
    NSDictionary *cell_data = [self.table_data objectAtIndex: indexPath.row];
    
    cell.drug_name.text = [NSString stringWithFormat:@"%@", cell_data[@"drug_name"]];
    cell.dosage.text = [NSString stringWithFormat:@"dosage: %@", cell_data[@"dosage"]];
    cell.date.text = [NSString stringWithFormat:@"prescribed date: %@", cell_data[@"date"]];
    
    cell.drug_image.layer.borderWidth = 3.0f;
    cell.drug_image.layer.borderColor = [UIColor colorWithRed:THEME_COLOR_RED green:THEME_COLOR_GREEN blue:THEME_COLOR_BLUE alpha:1].CGColor;
    cell.drug_image.layer.cornerRadius = 20.0f;
    cell.drug_image.clipsToBounds = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
@end
