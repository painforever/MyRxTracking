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
@end
