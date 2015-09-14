//
//  EditProfileViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/11/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "Manifest.h"

@interface EditProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UITextField *first_name;
@property (strong, nonatomic) IBOutlet UITextField *last_name;
@property (strong, nonatomic) IBOutlet UITextField *cell_phone;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *county;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *zipcode;
@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UIView *avatar_view;
@property (strong, nonatomic) IBOutlet UIView *address_view;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



- (IBAction)update_action:(id)sender;

- (IBAction)change_avatar_action:(id)sender;

//non control data
@property (strong, nonatomic) NSArray *userInputs;
@property (strong, nonatomic) NSString *non_blank_err_msg;
@property (strong, nonatomic) NSMutableDictionary *user_info;
@end
