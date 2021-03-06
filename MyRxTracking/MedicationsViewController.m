
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
    UIImageView *wall = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drug_list_photo.jpg"]];
    [wall setFrame:self.tableView.frame];
    self.tableView.backgroundView = wall;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.table_data = [(NSArray *)responseObject mutableCopy];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        NSLog(@"failed");
    }];
}
- (IBAction)add_med_action:(id)sender {
   // NewMedFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMedTableForm"];
   // [self.navigationController pushViewController:view animated:YES];
    
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
    if (cell == nil) {
        cell = [[DrugCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"drug_cell"];
    }
    NSDictionary *cell_data = [self.table_data objectAtIndex: indexPath.row];
    
    cell.drug_name.text = [NSString stringWithFormat:@"%@", cell_data[@"drug_name"]];
    cell.dosage.text = [NSString stringWithFormat:@"dosage: %@", cell_data[@"dosage"]];
    cell.date.text = [NSString stringWithFormat:@"prescribed date: %@", cell_data[@"date"]];
    
    cell.drug_image.layer.borderWidth = 3.0f;
    cell.drug_image.layer.borderColor = [UIColor colorWithRed:THEME_COLOR_RED green:THEME_COLOR_GREEN blue:THEME_COLOR_BLUE alpha:1].CGColor;
    cell.drug_image.layer.cornerRadius = 20.0f;
    cell.drug_image.clipsToBounds = YES;
    cell.backgroundColor = [UIColor clearColor];
    
    cell.take_button.tag = cell_data[@"rx_item_id"];
    cell.type = cell_data[@"type"];
    if ([cell.type isEqualToString:@"added"]) {
        [cell.take_button setEnabled: NO];
        [cell.take_button setHidden:YES];
    }
    else{
        [cell.take_button addTarget:self
                             action:@selector(take_it:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    //NSLog(@"remote: %@", [cell_data description]);
    if (![cell_data[@"remote_drug_photo_url"] isEqual: [NSNull null]]) {
        cell.drug_image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: cell_data[@"remote_drug_photo_url"]]]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *selected_data = [self.table_data objectAtIndex: indexPath.row];
    AdverseEventFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"AdverseEventFormViewController"];
    view.drug = selected_data;
    [self.navigationController pushViewController:view animated:YES];
}

-(IBAction)take_it:(id)sender{
    UIButton *clicked = (UIButton *)sender;
    NSString *rx_item_id = [NSString stringWithFormat:@"%@", clicked.tag];
    NSMutableDictionary *take_dic = [User takeDrug: rx_item_id];
    [self showAlert:@"Success" withMessage: take_dic[@"msg"]];
    if ([take_dic[@"finished"] isEqualToString:@"yes"]) {
        [[clicked superview] setUserInteractionEnabled: NO];
    }
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.table_data removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}
@end
