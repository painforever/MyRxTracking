//
//  SignUpViewController.m
//  RATracking
//
//  Created by Yu Song on 8/25/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}
- (IBAction)signup_action:(id)sender {
    NSString *email=self.email.text;
    NSString *password=self.password.text;
    NSString *password_con=self.password_confirm.text;
    NSString *first_name=self.first_name.text;
    NSString *last_name=self.last_name.text;
    
    if(![password isEqualToString: password_con]) {
        [self alert:@"Password is not same!" withMessage:@"Please confirm your password is match."];
        return;
    }
    if([[self trim:first_name] isEqualToString:@""]||[[self trim:last_name] isEqualToString:@""]){
        [self alert:@"Name blank!" withMessage:@"First Name and Last Name cannot be blank!"];
        return;
    }
    if([self checkEmailRepeat:email]){
        [self alert:@"Email already exists!" withMessage:@"The email is already existed, please try another one."];
        return;
    }
    
    NSString *res=[User signUp:email withPassword:password withFirstName:first_name withLastName:last_name];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData: res] options:NSJSONReadingMutableContainers error:nil];
    if([[dic objectForKey:@"status"] integerValue]==200){
        [self showAlert:@"Sign up success!" withMessage:@"Sign up success, you can not try to login!"];
        LoginViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:view animated:YES completion:nil];
    }
}

-(NSString *)trim: (NSString*)str{
    NSString * trimmedString = [str stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    return trimmedString;
}

-(void)alert: (NSString*)title withMessage:(NSString* )msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: msg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    return;
}

-(BOOL)checkEmailRepeat: (NSString *)email{
    NSString *res=[User checkEmailRepeat:email];
    if([res isEqualToString:@"yes"]) return YES;
    else return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
}
@end
