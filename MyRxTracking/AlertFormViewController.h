//
//  AlertFormViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface AlertFormViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *reminder_name;
@property (strong, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *repeat_times;
@property (strong, nonatomic) UIDatePicker *datePicker;

- (IBAction)add_action:(id)sender;

@end
