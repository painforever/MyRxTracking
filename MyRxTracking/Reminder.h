//
//  Reminder.h
//  MyRxTracking
//
//  Created by Yu Song on 9/2/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reminder : NSObject
+(NSDictionary *)constructParams: (NSString *)reminder_name withTime: (NSString *)time withRepeatTimes: (NSString *)repeat_times withUserID: (NSString *)passed_user_id;
@end
