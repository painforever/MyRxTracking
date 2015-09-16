//
//  File.m
//  MyRxTracking
//
//  Created by Yu Song on 9/16/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "File.h"

@implementation File
+(NSString *)getFileAbsPathByName:(NSString *)fileName{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent: fileName];
}

+(void)createFileByName:(NSString *)fileName{
    NSError *error;
    NSString *stringToWrite = @"";
    NSString *filePath = [File getFileAbsPathByName:fileName];
    [stringToWrite writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

+(void)writeToFileByName:(NSString *)fileName withContent:(NSString *)content{
    NSString *filePah = [File getFileAbsPathByName: fileName];
    [content writeToFile: filePah atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+(NSString *)readFileByName:(NSString *)fileName{
    NSString *filePath = [File getFileAbsPathByName: fileName];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    return content;
}

+(BOOL)fileExistsByName:(NSString *)fileName{
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath: [File getFileAbsPathByName: fileName]];
}

+(BOOL)deleteFileByName:(NSString *)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [self getFileAbsPathByName:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success){
        NSLog(@"trip file deleted!");
        return YES;
    }
    else{
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        return NO;
    }
}

@end
