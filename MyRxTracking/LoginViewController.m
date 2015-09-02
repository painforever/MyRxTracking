//
//  LoginViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/24/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController()

@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login_action:(id)sender {
    if (![self validUserInput])
        return;
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"sessions"] parameters:@{@"email": self.email.text, @"password": self.password.text} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *user_dic = (NSDictionary*)responseObject;
        //init NSUserDefaults
        userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue: user_dic[@"user_id"] forKey:@"user_id"];
        [userDefaults setValue: user_dic[@"patient_id"] forKey:@"patient_id"];
        [userDefaults synchronize];
        
        SideBarMenuController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:view animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        [self showAlert:@"Authentication failed" withMessage:@"Email or password is wrong!"];
    }];
}

- (IBAction)signup_action:(id)sender {
    
}

-(BOOL)validUserInput{
    self.userInputs = @[self.email, self.password];
    return [self globallyValidateUserInputs:self.userInputs];
}

- (IBAction)remember_me_value_changed:(id)sender {
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}
@end
