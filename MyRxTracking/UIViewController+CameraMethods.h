//
//  UIViewController+CameraMethods.h
//  MyRxTracking
//
//  Created by Yu Song on 9/15/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manifest.h"

@interface UIViewController (CameraMethods)
-(void)uploadAvatar: (UIImage *)file_data withFileName: (NSString *)filename withID: (NSString *)patient_reported_medications_id withFileParamKeyName: (NSString *)keyName withUploadingURL: (NSString *)url;
@end
