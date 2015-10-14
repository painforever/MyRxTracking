
//
//  PickerTimesViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 10/13/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "PickerTimesViewController.h"

@interface PickerTimesViewController ()

@end

@implementation PickerTimesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pick times";
    self.timeControls = [[NSMutableArray alloc] init];
    float x=(self.view.frame.size.width-300)/2;float y=100;
    for (int i=0;i<self.frequency;i++) {
        UITextField *field = [[UITextField alloc] init];
        [self addTextfieldToUIView: field withX:x withY:y withHeight:30.0 withWidth:300.0 withTag: i];
        y+=50;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITextField*)addTextfieldToUIView: (UITextField *)textField withX: (float)x withY: (float)y withHeight:(float)height withWidth: (float)width withTag: (int)tag{
    textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
    textField.placeholder = @"Pick a time";
    [textField setBorderStyle: UITextBorderStyleRoundedRect];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    textField.delegate = self;
    textField.tag = tag;
    [self.view addSubview: textField];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.tag = tag;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [textField setInputView: datePicker];
    datePicker.datePickerMode = UIDatePickerModeTime;
    
    [self.timeControls addObject: textField];
    return textField;
}

-(void)updateTextField: (id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    UITextField *field = [self getUIViewByTagFromArray:picker.tag withArray: self.timeControls];
    NSString *final_time = [[[NSString stringWithFormat:@"%@", picker.date] substringFromIndex:11] substringToIndex:8];
    [field setText: final_time];
}
@end
