
//
//  AlertFormViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "AlertFormViewController.h"

@implementation AlertFormViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"New Alert";
}
- (IBAction)add_action:(id)sender {
    if ([self validateInput])
        return;
    
}

-(BOOL)validateInput{
    NSArray *input_arr = @[self.reminder_name, self.medication_name, self.time];
    for (UITextField *input in input_arr) {
        if ([[self trim: input.text] length] == 0) {
            [self showAlert:[NSString stringWithFormat:@"%@ is blank", input.placeholder] withMessage:[NSString stringWithFormat:@"%@ cannot be blank!", input.placeholder]];
            return NO;
        }
    }
    return YES;
}
@end
