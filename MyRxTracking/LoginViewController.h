//
//  LoginViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/24/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarMenuController.h"
#import "Manifest.h"
#import "File.h"
#import "SignUpViewController.h"
#import "UIViewController+CWPopup.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *login_btn;
@property (strong, nonatomic) IBOutlet UIButton *signup_btn;
@property (strong, nonatomic) IBOutlet UISwitch *remember_me;

@property (strong, nonatomic) NSArray *userInputs;

- (IBAction)login_action:(id)sender;
- (IBAction)signup_action:(id)sender;
- (IBAction)remember_me_value_changed:(id)sender;
@end
