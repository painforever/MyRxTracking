
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
    [self loadMyDrugs];
    [self initPicker];
    
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    NSDate *date = [NSDate date];
//    // Set the fire date/time
//    [localNotification setFireDate:[date dateByAddingTimeInterval:5]];
//    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
//    
//    localNotification.applicationIconBadgeNumber=0;
//    
//    // Setup alert notification
//    [localNotification setAlertAction:@"Open App"];
//    [localNotification setAlertBody:@"songyu"];
//    [localNotification setAlertBody:@"You had set a Local Notification on this time"];
//    localNotification.soundName=UILocalNotificationDefaultSoundName;
//    [localNotification setHasAction:YES];
//    UIApplication *app=[UIApplication sharedApplication];
//    [app scheduleLocalNotification:localNotification];
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
        
//        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: @"11:54:00"];
//        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: @"11:55:00"];
//        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: @"11:56:00"];
//        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: @"11:57:00"];
//        [self scheduleReminder: alert_msg  withAlertSound:@"Alarm_1.mp3" withTime: @"11:58:00"];
        
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

-(void)initPicker{
    self.med_picker = [[UIPickerView alloc] init];
    self.med_picker.delegate = self;
    self.med_picker.dataSource = self;
    self.med_picker.showsSelectionIndicator = YES;
    UIBarButtonItem *med_name_done_button = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                             target:self action:@selector(done_for_med_name:)];
    UIToolbar *medNametoolBar = [[UIToolbar alloc]initWithFrame:
                                 CGRectMake(0, self.view.frame.size.height-
                                            self.med_picker.frame.size.height-50, 320, 50)];
    
    [medNametoolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *medNametoolbarItems = [NSArray arrayWithObjects:
                                    med_name_done_button, nil];
    [medNametoolBar setItems:medNametoolbarItems];
    //text fields
    self.medication_name.inputView = self.med_picker;
    self.medication_name.inputAccessoryView = medNametoolBar;
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)componen{
    [self.medication_name setText: self.med_arr[row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    return [self.med_arr objectAtIndex:row];
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.med_arr count];
}

#pragma load the drugs that currently taking
-(void)loadMyDrugs{
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *res_arr = (NSMutableArray *)responseObject;
        NSMutableDictionary *tmp_dic = [[NSMutableDictionary alloc] init];
        for(NSDictionary *obj in res_arr){
            tmp_dic[obj[@"drug_name"]] = @1;
        }
        self.med_arr = [tmp_dic allKeys];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
}

-(IBAction)done_for_med_name: (UIBarButtonItem*)btn{
    [self.medication_name resignFirstResponder];
}
@end
