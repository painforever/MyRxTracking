//
//  AFNetwork.m
//  MyRxTracking
//
//  Created by Yu Song on 8/31/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AFNetwork.h"
static AFHTTPRequestOperationManager *manager = nil;
@implementation AFNetwork
+(AFHTTPRequestOperationManager*)getAFManager{
    if(manager==nil)
        manager=[AFHTTPRequestOperationManager manager];
    return manager;
}
@end
