//
//  AdverseEventFormViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/28/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface AdverseEventFormViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *drug_image;

@property (weak, nonatomic) IBOutlet UILabel *drug_name;

@property (weak, nonatomic) IBOutlet UITextField *adverse_events;

@property (weak, nonatomic) IBOutlet UIButton *report_btn;

@property (weak, nonatomic) UIActionSheet *side_effects;

@property (strong, nonatomic) NSDictionary *drug;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UIButton *select_event_btn;

@property (strong, nonatomic) NSMutableArray *adverse_events_arr;

@property (strong, nonatomic) NSMutableArray *adverse_events_arr_for_submit;


- (IBAction)report_action:(id)sender;
- (IBAction)select_action:(id)sender;

- (void)showNormalActionSheet:(id)sender;

@end
