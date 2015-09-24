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
    self.drug_name = [NSString stringWithFormat:@"Name: %@", self.data[@"drug_name"]];
    NSLog(@"drug photo: %@", self.data[@"drug_photo"]);
    if ([self.data[@"drug_photo"][@"drug_photo"][@"url"] isEqual: [NSNull null]])
        self.drug_photo = @"no image";
    else self.drug_photo = self.data[@"drug_photo"][@"drug_photo"][@"url"];
    self.rx_id = [NSString stringWithFormat:@"Prescription ID: %@", self.data[@"rx_id"]];
    self.dosage = [NSString stringWithFormat:@"Dosage: %@", self.data[@"dosage"]];
    self.days_of_treatment = [NSString stringWithFormat:@"Days of treatment: %@", self.data[@"days_of_treatment"]];
    self.times_per_day = [NSString stringWithFormat:@"Times per day: %@", self.data[@"times_per_day"]];
    self.notes = self.data[@"notes"];
    
    self.rows = @{@"Medication Info": @[self.drug_photo, self.drug_name, self.rx_id, self.dosage], @"Other Info": @[self.days_of_treatment, self.times_per_day, self.notes]};
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
    NSLog(@"info: %@", info);
    NSLog(@"index: %d", indexPath.row);
    if ([sectionTitle isEqualToString:@"Medication Info"] && indexPath.row == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,200,200)];
        if ([info isEqualToString:@"no image"])
            imageView.image = [UIImage imageNamed:@"default-drug-image.png"];
        else{
            NSString *drug_photo = [NSString stringWithFormat:@"%@%@", BASE_URL, self.drug_photo];
            imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: drug_photo]]];
        }
        
        imageView.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2);
        [cell addSubview: imageView];
    }
    else if([sectionTitle isEqualToString:@"Other Info"] && indexPath.row == 2){
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 200, 200)];
        textView.userInteractionEnabled = NO;
        textView.textColor = [UIColor grayColor];
        textView.text = info;
        [cell addSubview: textView];
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@", info];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
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
