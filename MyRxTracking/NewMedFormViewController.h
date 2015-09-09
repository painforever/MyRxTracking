//
//  NewMedFormViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"

@interface NewMedFormViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *medication_name;
@property (strong, nonatomic) IBOutlet UITextField *dosage;
@property (strong, nonatomic) IBOutlet UIButton *take_photo_btn;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *selected_drug_id;

- (IBAction)take_photo_action:(id)sender;
- (IBAction)add_action:(id)sender;
@end
