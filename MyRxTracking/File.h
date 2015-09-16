//
//  File.h
//  MyRxTracking
//
//  Created by Yu Song on 9/16/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject
+(NSString*)getFileAbsPathByName: (NSString *)fileName;
+(void)createFileByName: (NSString *)fileName;

+(void)writeToFileByName: (NSString *)fileName withContent: (NSString *)content;

+(NSString *)readFileByName: (NSString *)fileName;

+(BOOL)fileExistsByName:(NSString *)fileName;

+(BOOL)deleteFileByName: (NSString *)fileName;
@end
