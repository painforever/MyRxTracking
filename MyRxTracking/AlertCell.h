//
//  AlertCell.h
//  MyRxTracking
//
//  Created by Yu Song on 9/2/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *reminder_name;
@property (strong, nonatomic) IBOutlet UILabel *drug_name;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end
