//
//  CouponsTableViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "CouponsTableViewController.h"

@interface CouponsTableViewController ()

@end

@implementation CouponsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.table_data = [[NSMutableArray alloc] init];
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"coupons"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *coupon in (NSMutableArray *)responseObject) {
            Coupon *cp = [Coupon initWithProperties:coupon[@"brand_name"] withVendorName:coupon[@"coupon_vendor"] withNDC:coupon[@"ndc"] withExpirationDate:coupon[@"expiration_date"] withPercentDiscount:coupon[@"percent_discount"] withBIN:coupon[@"bin"] withPCN:coupon[@"pcn"]];
            [self.table_data addObject: cp];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"failed");
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
    return self.table_data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Coupon *cp = [self.table_data objectAtIndex: indexPath.row];
    cell.name.text = cp.brand_name;
    cell.vendor_name.text = cp.vendor_name;
    cell.expiration_date.text = cp.expiration_date;
    cell.percent_discount.text = [NSString stringWithFormat:@"%@", cp.percent_discount];
    cell.ndc.text = cp.ndc;
    cell.company_logo.image = [UIImage imageNamed:@"eagleforce_logo.png"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CouponViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"CouponViewController"];
//    [self.navigationController pushViewController:view animated:YES];
}

@end
