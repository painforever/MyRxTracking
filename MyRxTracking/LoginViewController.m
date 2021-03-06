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
    //[self setUpAlertViewController];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.delegate = self;
    self.useBlurForPopup = YES;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{}];
    }
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

- (IBAction)forget_password_action:(id)sender {
    //[self presentViewController:self.forget_passsword animated:YES completion:nil];
    [self setUpAlertViewController];
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
    
    self.remember_me.onTintColor = [UIColor colorWithRed:39.0/255.0 green:182.0/255.0 blue:214.0/255.0 alpha:1.0];
}

#pragma set up the alert view controller
-(void)setUpAlertViewController{
    self.forget_passsword = [UIAlertController alertControllerWithTitle:@"Input Email" message:@"We will send you a temp password to use, and the original password will be invalid." preferredStyle:UIAlertControllerStyleAlert];
    [self.forget_passsword addTextFieldWithConfigurationHandler:^(UITextField *textField){
         textField.placeholder = NSLocalizedString(@"EmailPlaceholder", @"Email");
        [textField addTarget:self
                      action:@selector(emailTextFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
     }];
    
    self.okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   if ([[self trim:self.forgetpassword_email] length] == 0) {
                                       [self showAlert:@"Email cannot be blank!" withMessage:@"Email cannot be blank!"];
                                       return;
                                   }
                                   NSLog(@"email send to: %@", self.forgetpassword_email);
                                   [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"users/add_temp_password"] parameters:@{@"email": self.forgetpassword_email} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       [self showAlert:@"Email sent." withMessage:@"A temp password is already sent ot your email, you can use either the temp one or the original one to login."];
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       [self showAlert:@"Bad internet access." withMessage:@"The internet access is bad, please check the network visibility."];
                                   }];
                               }];
    [self.forget_passsword addAction: self.okAction];
    [self presentViewController:self.forget_passsword animated:YES completion:nil];
}

-(void)emailTextFieldDidChange:(UITextField *)sender{
    self.forgetpassword_email = sender.text;
}
@end
