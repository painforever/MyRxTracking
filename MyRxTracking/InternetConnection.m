

//
//  InternetConnection.m
//  EFAGreenBox
//
//  Created by Yu Song on 9/3/15.
//  Copyright (c) 2015 EFA. All rights reserved.
//

#import "InternetConnection.h"

@implementation InternetConnection
+(void)checkInternetConnection{
    Reachability *internetReachableFoo;
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
            if ( !is_online) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet access recovered"
                                                                message:@"Internet access recovered!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            is_online = YES;
            NSLog(@"bool %s", is_online ? "true" : "false");
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet :( ");
            if (is_online) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet work access."
                                                                message:@"No internet work connection!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            is_online = NO;
            
            NSLog(@"bool %s", is_online ? "true" : "false");
        });
    };
    [internetReachableFoo startNotifier];
}
@end
