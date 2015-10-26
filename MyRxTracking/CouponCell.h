//
//  CouponCell.h
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface CouponCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *company_logo;
@property (strong, nonatomic) IBOutlet UILabel *vendor_name;
@property (strong, nonatomic) IBOutlet UILabel *ndc;
@property (strong, nonatomic) IBOutlet UILabel *expiration_date;
@property (strong, nonatomic) IBOutlet UILabel *percent_discount;

@end
