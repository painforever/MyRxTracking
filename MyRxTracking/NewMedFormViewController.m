
//
//  NewMedFormViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "NewMedFormViewController.h"
#import "AFNetwork.h"
#import "Manifest.h"

@implementation NewMedFormViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"New Medication";
}
- (IBAction)take_photo_action:(id)sender {
}

- (IBAction)add_action:(id)sender {
    NSArray *inputs = @[self.medication_name, self.dosage];
    NSString *alert = [[NSString alloc] init];
    for (UITextField *input in inputs) {
        if ([[self trim: input.text] length] == 0) {
            alert = [NSString stringWithFormat:@"%@ cannot be blank", input.placeholder];
            [self showAlert: alert withMessage: alert];
            return;
        }
    }
    if (![JSONHandler isNnumber:self.dosage.text]) {
        [self showAlert:@"Dosage must be number" withMessage:@"Dosage must be number!"];
        return;
    }
    self.selected_drug_id = [NSString stringWithFormat:@"%@", [Drug searchDrug:self.medication_name.text]];
    if ([self.selected_drug_id isEqualToString:@"no"]) {
        [self showAlert:@"Cannot find this drug" withMessage:@"We are sorry but we cannot find this drug."];
        return;
    }
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"medications"] parameters:@{@"prm": @{@"patient_id": [userDefaults valueForKey:@"patient_id"], @"drug_id": self.selected_drug_id , @"dosage": self.dosage.text, @"prescribed_date": [NSDate date]}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res: %@", [responseObject description]);
        [self showAlert:@"Drug added" withMessage:@"Drug added!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *responseObject) {
        NSLog(@"failed");
    }];
}
@end
