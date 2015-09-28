//
//  AdverseEventFormViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/28/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdverseEventFormViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *drug_image;

@property (weak, nonatomic) IBOutlet UILabel *drug_name;

@property (weak, nonatomic) IBOutlet UITextField *adverse_events;

@property (weak, nonatomic) IBOutlet UIButton *report_btn;

@property (strong, nonatomic) NSDictionary *drug;

- (IBAction)report_action:(id)sender;

@end
