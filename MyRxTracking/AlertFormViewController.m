
//
//  AlertFormViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AlertFormViewController.h"

@implementation AlertFormViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"New Alert";
}
- (IBAction)add_action:(id)sender {
    if (![self validateInput])
        return;
    NSDictionary *params = [Reminder constructParams:self.reminder_name.text withMedicationName:self.medication_name.text withTime:self.time.text withRepeatTimes: self.repeat_times.text withUserID:[userDefaults stringForKey:@"user_id"]];
    
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"reminders"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Add alert success" withMessage:@"Alert added success!"];
        
        //start to schedule a single reminder
        NSString *alert_msg = [NSString stringWithFormat:@"%@ - %@", self.reminder_name.text, self.medication_name.text];
        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: self.time.text];
        self.medication_name.text = @"";self.time.text = @"";self.reminder_name.text = @"";self.repeat_times.text = @"";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}

-(BOOL)validateInput{
    NSArray *input_arr = @[self.reminder_name, self.medication_name, self.time, self.repeat_times];
    for (UITextField *input in input_arr) {
        if ([[self trim: input.text] length] == 0) {
            [self showAlert:[NSString stringWithFormat:@"%@ is blank", input.placeholder] withMessage:[NSString stringWithFormat:@"%@ cannot be blank!", input.placeholder]];
            return NO;
        }
    }
    return YES;
}
@end
