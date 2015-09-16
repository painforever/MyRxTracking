//
//  User.m
//  MyRxTracking
//
//  Created by Yu Song on 8/27/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "User.h"

@implementation User

-(User *)login:(NSString *)email withPassword:(NSString *)password{
    return nil;
}

+(NSMutableArray *)searchUsers:(NSString *)searchText{
    NSString *params = [NSString stringWithFormat:@"input=%@", searchText];
    NSString *res_str = [Get getRequest:[SERVER_URL stringByAppendingString:@"npis/search_doctor?"] withParams: params];
    NSMutableArray *res_arr = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData: res_str] options:NSJSONReadingMutableContainers error:nil];
    return res_arr;
}

+(NSMutableDictionary *)takeDrug:(NSString *)rx_item_id{
    NSString *params = [NSString stringWithFormat:@"rx_item_id=%@&patient_id=%@", rx_item_id, [userDefaults valueForKey:@"patient_id"]];
    NSString *res = [Post postRequest:[SERVER_URL stringByAppendingString:@"medications/take_drug"] withParams: params];
    NSMutableDictionary *res_dic = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData: res] options:NSJSONReadingMutableContainers error:nil];
    return res_dic;
}

//---------------sign up related--------------------------
+(NSString* )LogOut:(NSString *)user_id{
    NSString *str=[[NSString alloc] initWithFormat:@"user_id=%@", user_id];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"users/logout.json"] withParams:str];
}

+(NSString *)signUp:(NSString *)email withPassword:(NSString *)password withFirstName:(NSString *)first_name withLastName:(NSString *)last_name{
    NSString *param=[[NSString alloc] initWithFormat:@"email=%@&password=%@&first_name=%@&last_name=%@", email, password, first_name, last_name];
    return [Post postRequest:[SERVER_URL stringByAppendingString:@"users/patient_signup"] withParams:param];
}

+(NSString *)checkEmailRepeat:(NSString *)email{
    NSString *param=[[NSString alloc] initWithFormat:@"email=%@", email];
    NSString *res=[Get getRequest:[SERVER_URL stringByAppendingString:@"users/check_email_repeat.json?"] withParams: param];
    return res;
}
@end
