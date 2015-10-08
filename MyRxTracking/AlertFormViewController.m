
//
//  AlertFormViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AlertFormViewController.h"

@implementation AlertFormViewController
@synthesize datePicker;
-(void)viewDidLoad{
    [super viewDidLoad];
    self.time.delegate = self;
    self.title = @"New Alert";
    
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.time setInputView: datePicker];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.time.inputView;
    self.self.time.text = [NSString stringWithFormat:@"%@",picker.date];
}

- (IBAction)add_action:(id)sender {
    if (![self validateInput])
        return;
    NSDictionary *params = [Reminder constructParams:self.reminder_name.text withTime:self.time.text withRepeatTimes: self.repeat_times.text withUserID:[userDefaults stringForKey:@"user_id"]];
    
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"reminders"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Add alert success" withMessage:@"Alert added success!"];
        //start to schedule a single reminder
        NSString *alert_msg = self.reminder_name.text;
        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: self.time.text];
        self.time.text = @"";self.reminder_name.text = @"";self.repeat_times.text = @"";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}

-(BOOL)validateInput{
    NSArray *input_arr = @[self.reminder_name, self.time, self.repeat_times];
    for (UITextField *input in input_arr) {
        if ([[self trim: input.text] length] == 0) {
            [self showAlert:[NSString stringWithFormat:@"%@ is blank", input.placeholder] withMessage:[NSString stringWithFormat:@"%@ cannot be blank!", input.placeholder]];
            return NO;
        }
    }
    return YES;
}
@end
