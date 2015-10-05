//
//  ProfileViewController.h
//  MyRxTracking
//
//  Created by Yu Song on 8/24/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "EditProfileViewController.h"

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIView *avatar_view;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *full_name;
@property (strong, nonatomic) IBOutlet UILabel *phone;

@property (strong, nonatomic) IBOutlet UIView *contact_view;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *zipcode;
@property (strong, nonatomic) IBOutlet UILabel *county;
@property (strong, nonatomic) IBOutlet UILabel *email;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *insurance_view;
@property (strong, nonatomic) IBOutlet UILabel *pcn;
@property (strong, nonatomic) IBOutlet UILabel *group_number;
@property (strong, nonatomic) IBOutlet UILabel *insurance_plan_name;
@property (strong, nonatomic) IBOutlet UILabel *bc_bs_plan;
@property (strong, nonatomic) IBOutlet UILabel *insurance_company_name;
@property (strong, nonatomic) IBOutlet UILabel *id_number;
@property (strong, nonatomic) EditProfileViewController *edit_profile_view;
@property (weak, nonatomic) IBOutlet UILabel *ssn;
- (IBAction)edit_profile_action:(id)sender;

//data
@property (strong, nonatomic) NSMutableDictionary *contact_info;
@property (strong, nonatomic) NSMutableDictionary *insurance_info;
@property (strong, nonatomic) NSDictionary *plan_info;
@property (strong, nonatomic) NSString *avatar_url;


@end
