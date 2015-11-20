//
//  AdverseEventFormViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/28/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"
#import "UIViewController+CameraMethods.h"

@interface AdverseEventFormViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *drug_image;

@property (weak, nonatomic) IBOutlet UIImageView *adverse_event_part_image;

@property (weak, nonatomic) IBOutlet UILabel *drug_name;

@property (nonatomic) NSString *drug_image_file_name;

@property (weak, nonatomic) IBOutlet UITextField *adverse_events;

@property (weak, nonatomic) IBOutlet UIButton *report_btn;

@property (weak, nonatomic) UIActionSheet *side_effects;

@property (strong, nonatomic) NSDictionary *drug;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UIButton *select_event_btn;

@property (strong, nonatomic) NSMutableArray *adverse_events_arr;

@property (strong, nonatomic) NSMutableArray *adverse_events_arr_for_submit;
@property (weak, nonatomic) IBOutlet UIButton *take_picture_for_adverse_event_btn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) UIImagePickerController *cameraView;


- (IBAction)report_action:(id)sender;
- (IBAction)select_action:(id)sender;

- (void)showNormalActionSheet:(id)sender;

- (IBAction)take_picture_action:(id)sender;
@end
