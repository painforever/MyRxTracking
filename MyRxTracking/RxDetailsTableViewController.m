//
//  RxDetailsTableViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 9/24/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "RxDetailsTableViewController.h"
@interface RxDetailsTableViewController()
@property (nonatomic, strong) NSDictionary *rows;
@property (nonatomic, strong) NSArray *sections;
@end

@implementation RxDetailsTableViewController
-(void)viewDidLoad{
    self.drug_name = self.data[@"drug_name"];
    self.rows = @{@"Medication Info": @[@"photo", @"drug_name", @"rx_id", @"dosage"], @"Other Info": @[@"days_of_treatment", @"times_per_day", @"notes"]};
    self.sections = @[@"Medication Info", @"Other Info"];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return [self.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    NSString *sectionTitle = [self.sections objectAtIndex:section];
    NSArray *row = [self.rows objectForKey:sectionTitle];
    return [row count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *sectionTitle = [self.sections objectAtIndex:indexPath.section];
    NSArray *row = [self.rows objectForKey:sectionTitle];
    NSString *info = [row objectAtIndex:indexPath.row];
    cell.textLabel.text = info;
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    if ([sectionTitle isEqualToString:@"Medication Info"] && indexPath.row == 0) {
        NSLog(@"chu xian!!!! %@", info);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,200,200)];
        imageView.image = [UIImage imageNamed:@"male_default_avatar.png"];
        imageView.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2);
        [cell addSubview: imageView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && [indexPath section] == 0) {
        return 250;
    }
    if (indexPath.row == 2 && [indexPath section] == 1) {
        return 250;
    }
    return 50;
}

//load data
-(void)loadData{
    
}
@end
