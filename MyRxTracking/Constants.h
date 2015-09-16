//
//  Constants.h
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject
extern NSString *SERVER_URL;
extern NSString *BASE_URL;
extern NSUserDefaults *userDefaults;

extern NSString * AVATAR_URL;
extern NSString * DRUG_PHOTO_URL;

extern int const THEME_COLOR_RED;
extern int const THEME_COLOR_GREEN;
extern int const THEME_COLOR_BLUE;

extern NSString *REMEMBERED_EMAIL_FILENAME;
extern NSString *REMEMBERED_PASS_FILENAME;
extern NSString *REMEMBERED_USER_DATA;

extern BOOL is_online;
@end
