//
//  User.h
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manifest.h"

@interface User : NSObject

-(User*)login: (NSString *)email withPassword:(NSString *)password;
+(NSMutableArray *)searchUsers:(NSString *)searchText;
+(NSMutableDictionary *)takeDrug: (NSString *)rx_item_id;

+(NSString *)LogOut:(NSString*)user_id;

+(NSString*)signUp:(NSString *)email withPassword:(NSString *)password withFirstName:(NSString*)first_name withLastName:(NSString *)last_name;

+(NSString *)checkEmailRepeat: (NSString *)email;
@end
