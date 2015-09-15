//
//  UIViewController+CameraMethods.m
//  MyRxTracking
//
//  Created by Yu Song on 9/15/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "UIViewController+CameraMethods.h"

@implementation UIViewController (CameraMethods)

-(void)uploadAvatar: (UIImage *)file_data withFileName: (NSString *)filename withID: (NSString *)patient_reported_medications_id withFileParamKeyName:(NSString *)keyName withUploadingURL:(NSString *)url{
    NSData* imageData =  UIImageJPEGRepresentation(file_data, 1.0);
    // NSData *imageData   = [NSData dataWithContentsOfFile:filename];
    NSString *urlString = url;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@",[[NSUUID UUID] UUIDString]];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *userid = [NSString stringWithFormat:@"%@",patient_reported_medications_id];
    [body appendData:[userid dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", keyName, filename]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

@end
