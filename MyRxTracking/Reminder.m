//
//  Reminder.m
//  MyRxTracking
//
//  Created by Yu Song on 9/2/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder
+(NSDictionary *)constructParams:(NSString *)reminder_name withMedicationName:(NSString *)med_name withTime:(NSString *)time withUserID:(NSString *)passed_user_id{
    NSDictionary *params = @{@"reminder": @{@"reminder_name": reminder_name, @"drug_name": med_name, @"reminder_time": time, @"user_id": passed_user_id}};
    return params;
}
@end
