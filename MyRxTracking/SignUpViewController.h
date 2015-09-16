//
//  SignUpViewController.h
//  RATracking
//
//  Created by Yu Song on 8/25/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SharedUIMethods.h"
#import "LoginViewController.h"
#import "Manifest.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *first_name;
@property (strong, nonatomic) IBOutlet UITextField *last_name;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password_confirm;
@property (strong, nonatomic) IBOutlet UIButton *signup_btn;
- (IBAction)signup_action:(id)sender;

@end
