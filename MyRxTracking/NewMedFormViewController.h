//
//  NewMedFormViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "PickerTimesViewController.h"
#import "UIViewController+CameraMethods.h"
#import "UIViewController+CWPopup.h"
#import "CouponViewController.h"
#import "CouponsTableViewController.h"

@interface NewMedFormViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *medication_name;
@property (strong, nonatomic) IBOutlet UITextField *dosage;
@property (strong, nonatomic) IBOutlet UIButton *take_photo_btn;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *cameraView;

@property (strong, nonatomic) NSString *selected_drug_id;
@property (strong, nonatomic) NSString *drug_image_file_name;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;


@property (weak, nonatomic) IBOutlet UISwitch *switcher;
@property (weak, nonatomic) IBOutlet UIButton *setup_time_btn;
@property (weak, nonatomic) IBOutlet UITextField *frequency;
@property (weak, nonatomic) IBOutlet UITextField *repeat;
@property (strong, nonatomic) NSArray *controls;
@property (strong, nonatomic) NSMutableArray *scheduledNotificationTimes;
@property (strong, nonatomic) PickerTimesViewController *pickerTimeView;
- (IBAction)coupon_action:(id)sender;



- (IBAction)take_photo_action:(id)sender;
- (IBAction)add_action:(id)sender;
- (IBAction)setup_times_action:(id)sender;
- (IBAction)switcher_value_changed:(id)sender;
@end
