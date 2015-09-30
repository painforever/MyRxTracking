//
//  UIViewController+SharedUIMethods.h
//  TrackPacker
//
//  Created by Yu Song on 7/21/15.
//  Copyright (c) 2015 TrackPacker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetwork.h"
#import "Constants.h"

@interface UIViewController (SharedUIMethods) <SRWebSocketDelegate>

-(void)showAlert: (NSString *)title withMessage: (NSString *)msg;

//trim whitespace
-(NSString *)trim: (NSString *)str;
//check whether is number
-(BOOL)isNnumber: (NSString *)input;
//clear all the inputs fields
-(void)clearAllTextFields: (NSArray *)text_fields;

-(BOOL)globallyValidateUserInputs:(NSArray *)inputs;

//get the all formated date by appending only time, the format is yyyy-MM-dd HH:mm:ss
-(NSDate *)getEntireFormattedDateByAppendingTime: (NSString *)time;

//gloabally schedule 1 reminder
-(void)scheduleReminder: (NSString *)msg withAlertSound: (NSString *)soundName withTime: (NSString *)time;

//globally schedule multiple reminders
-(void)scheduleReminders: (NSString *)days withTimes: (NSArray *)times_arr withDrugName: (NSString *)drug_name;

//schedule all the Rx related reminders once the user is login.
-(void)scheduleRxReminders: (NSString *)patient_id;

-(UIView *)setLeftViewForTextfields:(NSString *)imageName withContainerScale:(int)containerScale withImageIconScale:(int)imageScale withUITextField:(UITextField *)textfield;

//display and style only for the drug image
-(void)displayAndStyleDrugImage: (id)imageUrl withImageView: (UIImageView *)imageView withImageKeyName: (NSString *)key;

-(void)getSelf;
@end
