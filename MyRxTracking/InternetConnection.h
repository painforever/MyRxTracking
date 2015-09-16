//
//  InternetConnection.h
//  EFAGreenBox
//
//  Created by Yu Song on 9/3/15.
//  Copyright (c) 2015 EFA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability/Reachability.h"
#import "Constants.h"
@interface InternetConnection : UIViewController
+(void)checkInternetConnection;
@end
