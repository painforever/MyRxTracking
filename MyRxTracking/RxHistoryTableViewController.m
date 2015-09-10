//
//  RxHistoryTableViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 9/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "RxHistoryTableViewController.h"
#import "RxHistoryCell.h"

@interface RxHistoryTableViewController ()

@end

@implementation RxHistoryTableViewController
@synthesize table_data;
@synthesize rx_row;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"My Rx History";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"rxs"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        table_data = (NSMutableArray *)responseObject;
        [self.tableView reloadData];
        NSLog(@"res; %@", [table_data description]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.table_data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RxHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rx_cell" forIndexPath:indexPath];
    rx_row = table_data[indexPath.row];
    cell.drug_name.text = rx_row[@"drug_name"];
    if (![rx_row[@"notes"] isEqual: [NSNull null]])
      cell.notes.text = rx_row[@"notes"];
    else cell.notes.text = @"no notes for this medication.";
    cell.rx_id.text = [NSString stringWithFormat:@"Rx id: %@", [rx_row[@"rx_id"] stringValue]];
    cell.is_finished.text = [NSString stringWithFormat:@"Finished? : %@", rx_row[@"is_finished"]];
    
    if ([rx_row[@"is_finished"] isEqualToString:@"no"])
        cell.is_finished.textColor = [UIColor redColor];
    else cell.is_finished.textColor = [UIColor blueColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.rxDetailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"RxDetailsViewController"];
    [self.navigationController pushViewController:self.rxDetailsView animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
