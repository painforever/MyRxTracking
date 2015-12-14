//
//  ProfileViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/24/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "ProfileViewController.h"
#import "Manifest.h"
#import "File.h"


@interface ProfileViewController()

@end

@implementation ProfileViewController
@synthesize contact_info;
@synthesize insurance_info;
@synthesize plan_info;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Profile";
    [self setUpStyle];
    //schedule the reminders
    if ([File fileExistsByName: REMEMBERED_USER_DATA]) {
        //[self scheduleRxReminders: [userDefaults valueForKey:@"patient_id"]];
    }
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"profiles"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *all_info = (NSMutableDictionary *)responseObject;
        [self loadContactInfo: all_info];
        [self loadInsuranceInfo:all_info];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        
    }];
}

-(void)loadContactInfo: (NSMutableDictionary *)all_info{
    contact_info = all_info[@"contact_info"];
    self.avatar_url = [NSString stringWithFormat:@"%@%@", BASE_URL, contact_info[@"avatar"][@"url"]];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString: self.avatar_url] placeholderImage:[UIImage imageNamed:@"male_default_avatar"]];
    
    self.full_name.text = [NSString stringWithFormat:@"%@ %@", contact_info[@"fname"], contact_info[@"lname"]];
    self.city.text = [NSString stringWithFormat:@"City: %@", contact_info[@"city"]];
    self.state.text = [NSString stringWithFormat:@"State: %@", contact_info[@"state"]];
    self.country.text = [NSString stringWithFormat:@"Country: %@", contact_info[@"country"]];
    self.county.text = [NSString stringWithFormat:@"County: %@", contact_info[@"county"]];
    self.zipcode.text = [NSString stringWithFormat:@"Zipcode: %@", contact_info[@"zipcode"]];
    self.phone.text = [NSString stringWithFormat:@"Phone: %@", contact_info[@"cell_phone_number"]];
    self.email.text = [NSString stringWithFormat:@"Email: %@", contact_info[@"email_address"]];
    self.email.numberOfLines = 2;
    self.address.text = [NSString stringWithFormat:@"Address: %@", contact_info[@"home_address1"]];
    //NSLog(@"contact: %@", [contact_info[@"avatar"]  description]);
    if ([contact_info[@"avatar"][@"url"] isEqual: [NSNull null]]) {
        if ([[contact_info[@"gender"] uppercaseString] isEqualToString:@"F"])
            self.avatar.image = [UIImage imageNamed: @"female_default_avatar.png"];
        else self.avatar.image = [UIImage imageNamed:@"male_default_avatar.png"];
    }
    else{}
}

-(void)loadInsuranceInfo: (NSMutableDictionary *)all_info{
    self.insurance_company_name.numberOfLines = 10;
    self.insurance_plan_name.numberOfLines = 10;
    insurance_info = all_info[@"insurance_info"];
    plan_info = all_info[@"plan"];
    if (![plan_info isEqual:[NSNull null]]) {
         self.insurance_company_name.text = [NSString stringWithFormat:@"Company Name: %@", [self nilOrIntToString: plan_info[@"org_name"]]];
        self.insurance_plan_name.text = [NSString stringWithFormat:@"Plan Name: %@", plan_info[@"plan_name"]];
    }
    if (![insurance_info isEqual: [NSNull null]]) {
        self.group_number.text = [NSString stringWithFormat:@"Group ID: %@", insurance_info[@"group_id"]];
    }
    self.ssn.text = [NSString stringWithFormat:@"SSN: %@", [self nilOrIntToString: all_info[@"patient"][@"ssn"]]];
}

-(void)setUpStyle{
    self.avatar.layer.borderWidth = 1.0f;
    self.avatar.layer.cornerRadius = self.avatar.layer.frame.size.height/2;
    self.avatar.clipsToBounds = YES;
    self.avatar.contentMode = UIViewContentModeScaleAspectFit;
    
    //scrollView
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.insurance_view.frame.origin.y+self.insurance_view.frame.size.height+300);
}
- (IBAction)edit_profile_action:(id)sender {
    self.edit_profile_view = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    //assign the info to edit view controller
    
    NSArray *full_name = [self.full_name.text componentsSeparatedByString:@" "];
    
    self.edit_profile_view.user_info = @{@"first_name": full_name[0], @"last_name": full_name[1], @"country": self.country.text, @"county": self.county.text, @"cell_phone": self.phone.text, @"address": self.address.text, @"state": self.state.text, @"city": self.city.text, @"zipcode": self.zipcode.text, @"email": self.email.text, @"avatar_url": self.avatar_url};
    [self.navigationController pushViewController:self.edit_profile_view animated:YES];
}
@end
