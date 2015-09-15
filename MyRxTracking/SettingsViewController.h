//
//  SettingsViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 9/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface SettingsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *cellphone;
@property (strong, nonatomic) IBOutlet UITextField *old_password;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password_confirm;
@property (strong, nonatomic) IBOutlet UIButton *update_btn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)update_action:(id)sender;

@end
