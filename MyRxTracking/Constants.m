//
//  Constants.m
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Constants.h"

@implementation Constants
NSUserDefaults *userDefaults;

NSString *SERVER_URL = @"http://10.0.80.51:3000/my_rx_tracking/";
NSString *BASE_URL = @"http://10.0.80.51:3000";
NSString *DRUG_PHOTO_URL=@"http://10.0.80.51:3000/my_rx_tracking/medications/upload_drug_photo";
NSString *AVATAR_URL=@"http://10.0.80.51:3000/my_rx_tracking/profiles/upload_avatar";
NSString *WEBSOCKET_URL=@"http://10.0.80.51:8998";


//NSString * AVATAR_URL=@"http://127.0.0.1:3000/my_rx_tracking/profiles/upload_avatar";
//NSString * DRUG_PHOTO_URL=@"http://127.0.0.1:3000/my_rx_tracking/medications/upload_drug_photo";
//NSString *BASE_URL = @"http://127.0.0.1:3000";
//NSString *SERVER_URL = @"http://127.0.0.1:3000/my_rx_tracking/";
//NSString *WEBSOCKET_URL=@"http://127.0.0.1:3000/";

SRWebSocket *websocket;


int const THEME_COLOR_RED = 39;
int const THEME_COLOR_GREEN = 82;
int const THEME_COLOR_BLUE = 214;

NSString *REMEMBERED_EMAIL_FILENAME = @"email.txt";;
NSString *REMEMBERED_PASS_FILENAME = @"pass.txt";
NSString *REMEMBERED_USER_DATA = @"user_data.txt";

BOOL is_online = YES;
@end
