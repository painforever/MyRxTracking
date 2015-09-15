
//
//  Drug.m
//  MyRxTracking
//
//  Created by Yu Song on 9/9/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "Drug.h"

@implementation Drug

+(NSMutableDictionary *)searchDrug:(NSString *)drug_name{
    NSString *params = [NSString stringWithFormat:@"drug_name=%@", drug_name];
    NSString *res = [Get getRequest:[SERVER_URL stringByAppendingString: @"medications/search_drug?"] withParams:params];
    NSDictionary *res_dic = [NSJSONSerialization JSONObjectWithData:[JSONHandler StringToData: res] options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"drug_id : %@", res_dic[@"result"][@"drug_id"]);
    return res_dic;
}
@end
