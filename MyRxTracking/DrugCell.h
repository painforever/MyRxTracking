//
//  DrugCell.h
//  MyRxTracking
//
//  Created by Yu Song on 9/9/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface DrugCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *drug_name;
@property (strong, nonatomic) IBOutlet UILabel *dosage;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIImageView *drug_image;
@property (strong, nonatomic) IBOutlet UIButton *take_button;
@property (strong, nonatomic) NSString *type;
@end
