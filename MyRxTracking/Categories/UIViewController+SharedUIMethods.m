//
//  UIViewController+SharedUIMethods.m
//  TrackPacker
//
//  Created by Yu Song on 7/21/15.
//  Copyright (c) 2015 TrackPacker. All rights reserved.
//

#import "UIViewController+SharedUIMethods.h"

@implementation UIViewController (SharedUIMethods)

-(void)showAlert: (NSString *)title withMessage: (NSString *)msg{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:title
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
}

-(NSString *)trim: (NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(BOOL)isNnumber:(NSString *)input{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *matches = [regex firstMatchInString:input options:0 range:NSMakeRange(0, input.length)];
    return matches != nil;
}

-(void)clearAllTextFields:(NSArray *)text_fields{
    for (UITextField *text_field in text_fields){
        text_field.text = @"";
    }
}

-(BOOL)globallyValidateUserInputs:(NSArray *)inputs{
    for (UITextField *input in inputs) {
        if ([[self trim: input.text] length] == 0) {
            [self showAlert:[NSString stringWithFormat:@"%@ is blank", input.placeholder] withMessage:[NSString stringWithFormat:@"%@ cannot be blank!", input.placeholder]];
            return NO;
        }
    }
    return YES;
}

-(NSDate *)getEntireFormattedDateByAppendingTime:(NSString *)time{
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate=[formater stringFromDate:[NSDate date]];
    stringFromDate=[[stringFromDate stringByAppendingString:@" "] stringByAppendingString: time];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formater dateFromString:stringFromDate];
    NSLog(@"date: %@", date);
    return date;
}

-(void)scheduleReminder:(NSString *)msg withAlertSound:(NSString *)soundName withTime:(NSString *)time{
    NSDate *date = [self getEntireFormattedDateByAppendingTime: time];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.repeatInterval = NSDayCalendarUnit;
    [notification setAlertBody: msg];
    [notification setFireDate: date];
    //[notification setFireDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    notification.soundName = soundName;
    [[UIApplication sharedApplication] scheduleLocalNotification: notification];
}

-(void)scheduleReminders:(NSString *)days withTimes:(NSArray *)times_arr withDrugName:(NSString *)drug_name{
    int treatment_days = [days intValue];
    for (int i = 0; i < treatment_days; i++) {
        for (int j = 0; j < [times_arr count]; j++) {
            NSDate *date = [self getEntireFormattedDateByAppendingTime: times_arr[j]];
            //we assume that the start of taking the drug will be the day after the patient scheduling
            NSDateComponents *components= [[NSDateComponents alloc] init];
            [components setDay:i];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *dateIncremented= [calendar dateByAddingComponents:components toDate:date options:0];
            //start to init the Notifications
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.repeatInterval = NSDayCalendarUnit;
            NSString *alert_msg = [NSString stringWithFormat:@"It's time to take %@.", drug_name];
            [notification setAlertBody: alert_msg];
            [notification setFireDate: dateIncremented];
            notification.soundName = @"Alarm_1.mp3";
            [notification setTimeZone:[NSTimeZone  defaultTimeZone]];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}

-(void)scheduleRxReminders:(NSString *)patient_id{
    [[AFNetwork getAFManager] GET:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"patient_id": [userDefaults valueForKey:@"patient_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = (NSMutableArray *)responseObject;
        for (NSDictionary *item in arr) {
            if (![item[@"time_of_day"] isEqual: [NSNull null]]) {
                [self scheduleReminders: item[@"days_of_treatment"] withTimes: [item[@"time_of_day"] componentsSeparatedByString:@","] withDrugName: item[@"drug_name"]];
                NSLog(@"Yue Le");
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        NSLog(@"failed to load and schedule");
    }];
}


-(UIView *)setLeftViewForTextfields:(NSString *)imageName withContainerScale:(int)containerScale withImageIconScale:(int)imageScale withUITextField:(UITextField *)textfield{
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, imageScale, imageScale)];
    iconImage.image = [UIImage imageNamed: imageName];
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerScale, containerScale)];
    container.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [container addSubview: iconImage];
    textfield.leftViewMode = UITextFieldViewModeAlways;
    return container;
}

#pragma mark - SRWebSocket delegate

- (void)connectWebSocket {
    NSString *urlString=[NSString stringWithFormat: [WEBSOCKET_URL stringByAppendingString:@"?user_id=%@"],[userDefaults valueForKey:@"user_id"]];
    websocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    websocket.delegate=self;
    [websocket open];
}

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    // [self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    // [self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data=[message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"New message" message: [dic objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [messageAlert show];
}

-(void)displayAndStyleDrugImage:(id)imageUrl withImageView:(UIImageView *)imageView withImageKeyName:(NSString *)key{
    //display it
    NSString *drug_image_url = @"";
    if ([imageUrl isKindOfClass: [NSDictionary class]] || [imageUrl isKindOfClass: [NSMutableDictionary class]]){
        drug_image_url = imageUrl[key];
    }
    else{
        drug_image_url = imageUrl;
    }
    
    if (![drug_image_url isEqual: [NSNull null]]) {
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: drug_image_url]]];
    }
    else
        imageView.image = [UIImage imageNamed:@"default-drug-image.png"];
    
    //style it
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor colorWithRed:THEME_COLOR_RED green:THEME_COLOR_GREEN blue:THEME_COLOR_BLUE alpha:1].CGColor;
    imageView.layer.cornerRadius = 20.0f;
    imageView.clipsToBounds = YES;
}

-(void)setScrollViewSiseForAllKindsOfDevices: (UIScrollView *)scrollView withView:(UIView *)view{
    scrollView.userInteractionEnabled = YES;
    CGFloat bottom_coor = view.frame.origin.y + 150;
    if (IS_IPHONE4)
        scrollView.contentSize = CGSizeMake(320, bottom_coor);
    else if (IS_IPHONE5)
        scrollView.contentSize = CGSizeMake(320, bottom_coor);
    else if (IS_IPHONE6)
        scrollView.contentSize = CGSizeMake(375, bottom_coor);
    else if (IS_IPHONE6PLUS)
        scrollView.contentSize = CGSizeMake(414, bottom_coor);
}

-(void)setOneViewCenterAlign:(UIView *)view withParentView:(UIView *)parentView{
    view.center = CGPointMake(parentView.bounds.size.width/2, parentView.bounds.size.height/2);
}

-(void)setAllViewCenterAlign:(NSArray *)views withParentView:(UIView *)parentView{
    for (UIView *view in views) {
        [self setOneViewCenterAlign:view withParentView: parentView];
    }
}

-(NSArray *)getUITextfieldTextInArray:(NSMutableArray *)textFields{
    return Underscore.array(textFields).map(^NSString *(UITextField *field){
        return field.text;
    }).unwrap;
}

-(UIView *)getUIViewByTagFromArray:(int)tag withArray:(NSMutableArray *)array{
    for (UIView *obj in array) {
        if (obj.tag == tag) {
            return obj;
        }
    }
    return nil;
}

-(void)getSelf{
    NSLog(@"self: %@", [[self class] description]);
}
@end
