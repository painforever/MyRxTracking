//
//  SideBarMenuController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/24/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SideBarMenuController.h"

@implementation SideBarMenuController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.menuItems = @[@"logo", @"profile", @"medications", @"alerts", @"my_doctors", @"rx_history", @"coupons", @"settings", @"logout"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else return [[UITableViewCell alloc] init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //logout
    if (indexPath.row == 8) {
        userDefaults = nil;
        [File deleteFileByName: REMEMBERED_EMAIL_FILENAME];
        [File deleteFileByName:REMEMBERED_PASS_FILENAME];
        [File deleteFileByName:REMEMBERED_USER_DATA];
        LoginViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:view animated:YES completion:nil];
    }
}
@end
