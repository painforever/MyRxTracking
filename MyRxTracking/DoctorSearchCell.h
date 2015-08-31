//
//  DoctorSearchCell.h
//  MyRxTracking
//
//  Created by Yu Song on 8/31/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorSearchCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *full_name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *npi;
@property (strong, nonatomic) IBOutlet UILabel *gender;

@end
