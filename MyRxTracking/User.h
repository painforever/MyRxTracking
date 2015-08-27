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
@end
