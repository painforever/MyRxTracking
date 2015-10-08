//
//  NewMedTableForm.h
//  MyRxTracking
//
//  Created by Yu Song on 10/8/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface NewMedTableForm : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *medication_name;
@property (strong, nonatomic) IBOutlet UITextField *dosage;
@property (strong, nonatomic) IBOutlet UIImageView *drug_photo;
@property (strong, nonatomic) IBOutlet UITextField *frequency;

@property (strong, nonatomic) IBOutlet UIButton *take_photo_btn;
@property (strong, nonatomic) IBOutlet UIButton *add_btn;
@end
