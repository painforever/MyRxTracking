//
//  UIViewController+SharedUIMethods.h
//  TrackPacker
//
//  Created by Yu Song on 7/21/15.
//  Copyright (c) 2015 TrackPacker. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (SharedUIMethods)

-(void)showAlert: (NSString *)title withMessage: (NSString *)msg;

//trim whitespace
-(NSString *)trim: (NSString *)str;
//check whether is number
-(BOOL)isNnumber: (NSString *)input;
//clear all the inputs fields
-(void)clearAllTextFields: (NSArray *)text_fields;

-(BOOL)globallyValidateUserInputs:(NSArray *)inputs;
@end
