//
//  Reminder.m
//  MyRxTracking
//
//  Created by Yu Song on 9/2/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder
+(NSDictionary *)constructParams:(NSString *)reminder_name withTime:(NSString *)time withRepeatTimes: (NSString *)repeat_times withUserID:(NSString *)passed_user_id{
    NSDictionary *params = @{@"reminder": @{@"reminder_name": reminder_name, @"reminder_time": time, @"user_id": passed_user_id, @"repeat_times": repeat_times}};
    return params;
}
@end
