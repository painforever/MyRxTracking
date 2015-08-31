//
//  Post.h
//  new_green_box
//
//  Created by Yu on 12/4/14.
//  Copyright (c) 2014 Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
+(NSString*)postRequest:(NSString*)url withParams:(NSString*)params;
+(void)postAsyncRequest: (NSString *)url withParams:(NSString *)params;
@end
