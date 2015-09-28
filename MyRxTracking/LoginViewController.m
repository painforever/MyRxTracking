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
    [self styleLoginControls];
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
        
        //remember account
        if (self.remember_me.on) [self storeAccount];
        //schedule reminders
        [self scheduleRxReminders: [userDefaults valueForKey:@"patient_id"]];
        
        SideBarMenuController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self presentViewController:view animated:YES completion:nil];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError *error) {
        [self showAlert:@"Authentication failed" withMessage:@"Email or password is wrong!"];
    }];
}

- (IBAction)signup_action:(id)sender {
    SignUpViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    view.view.frame = CGRectMake(0, 0, self.view.frame.size.width-50, self.view.frame.size.height-150);
    [self presentPopupViewController:view animated:YES completion:nil];
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

-(void)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
}

#pragma methods for remembering password

//this method must be called after userDefault data synced
-(void)storeAccount{
    [File createFileByName: REMEMBERED_EMAIL_FILENAME];[File writeToFileByName: REMEMBERED_EMAIL_FILENAME withContent: self.email.text];
    [File createFileByName: REMEMBERED_PASS_FILENAME];[File writeToFileByName: REMEMBERED_PASS_FILENAME withContent: self.password.text];
    NSArray *user_data_arr = @[[userDefaults valueForKey:@"user_id"], [userDefaults valueForKey:@"patient_id"]];
    [File createFileByName: REMEMBERED_USER_DATA];[File writeToFileByName: REMEMBERED_USER_DATA withContent: [user_data_arr componentsJoinedByString:@","]];
}

#pragma styles for controls
-(void)styleLoginControls{
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"envelope.png"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    
    UIImageView *passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"account.png"];
    UIView *passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview: passwordIconImage];
    
    self.email.leftViewMode = UITextFieldViewModeAlways;
    self.email.leftView = usernameIconContainer;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.password.leftView = passwordIconContainer;
}
@end
