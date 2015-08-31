//
//  AFNetwork.h
//  MyRxTracking
//
//  Created by Yu Song on 8/31/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface AFNetwork : NSObject

+(AFHTTPRequestOperationManager*)getAFManager;
@end
