//
//  Constants.h
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>

// ******************* DEVICE INDENTIFICATION MACROS *****************//
#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE5          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE6          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE6PLUS      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_RETINA           ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

@interface Constants : NSObject
extern NSString *SERVER_URL;
extern NSString *BASE_URL;
extern NSUserDefaults *userDefaults;

extern NSString * AVATAR_URL;
extern NSString * DRUG_PHOTO_URL;
extern NSString * ADVERSE_EVENT_PHOTO;

extern int const THEME_COLOR_RED;
extern int const THEME_COLOR_GREEN;
extern int const THEME_COLOR_BLUE;

//websocket
extern NSString *WEBSOCKET_URL;
extern SRWebSocket *websocket;

extern NSString *REMEMBERED_EMAIL_FILENAME;
extern NSString *REMEMBERED_PASS_FILENAME;
extern NSString *REMEMBERED_USER_DATA;

extern BOOL is_online;
@end
