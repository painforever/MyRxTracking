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
@end
