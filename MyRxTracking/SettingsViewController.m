//
//  SettingsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 9/10/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIViewController+SharedUIMethods.h"
#import "Manifest.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    //scrollView
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(400, self.view.frame.size.height+200);
    
    self.email.leftView = [self setLeftViewForTextfields:@"envelope.png" withContainerScale:50 withImageIconScale:24 withUITextField:self.email];
    self.old_password.leftView = [self setLeftViewForTextfields:@"settings.png" withContainerScale:50 withImageIconScale:24 withUITextField:self.old_password];
    self.password.leftView = [self setLeftViewForTextfields:@"settings.png" withContainerScale:50 withImageIconScale:24 withUITextField:self.password];
    self.password_confirm.leftView = [self setLeftViewForTextfields:@"settings.png" withContainerScale:50 withImageIconScale:24 withUITextField:self.password_confirm];
    self.cellphone.leftView = [self setLeftViewForTextfields:@"account.png" withContainerScale:50 withImageIconScale:24 withUITextField:self.cellphone];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)update_action:(id)sender {
    BOOL valid = [self validateInputs];
    if (!valid)
        return;
    [[AFNetwork getAFManager] PATCH: [[SERVER_URL stringByAppendingString:@"profiles/"] stringByAppendingString: [[userDefaults valueForKey:@"user_id"] stringValue]] parameters:@{@"user": @{@"email_address": self.email.text, @"cell_phone_number": self.cellphone.text, @"old_password": self.old_password.text, @"password": self.password.text, @"temp_password": [NSNull null]}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"result: %@", [responseObject description]);
        [self showAlert:@"Update success" withMessage:@"Update success!"];
        
        //reset the stored password file on disk
        [File deleteFileByName:REMEMBERED_PASS_FILENAME];
        [File createFileByName:REMEMBERED_PASS_FILENAME];
        [File writeToFileByName:REMEMBERED_PASS_FILENAME withContent:self.password.text];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.response.statusCode == 401) {
            [self showAlert:@"The previous password is not correct." withMessage:@"Original password is not correct, please input valid password and then you can set a new password."];
        }
    }];
}

-(BOOL)validateInputs{
    NSArray *inputs = @[self.email, self.cellphone, self.old_password, self.password, self.password_confirm];
    BOOL valid = [self globallyValidateUserInputs: inputs];
    if (![self.password.text isEqualToString: self.password_confirm.text]) {
        [self showAlert:@"Password confirm not match" withMessage:@"Your password does not match the confirm."];
        return false;
    }
    return valid;
}
@end
