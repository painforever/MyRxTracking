//
//  AdverseEventFormViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 9/28/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "AdverseEventFormViewController.h"

@implementation AdverseEventFormViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.side_effects.delegate = self;
    self.adverse_events_arr_for_submit = [[NSMutableArray alloc] init];
    //NSLog(@"dic: %@", self.drug.description);
    NSString *drug_id = [NSString stringWithFormat:@"%@", self.drug[@"drug_id"]];
    [[AFNetwork getAFManager] GET:[[SERVER_URL stringByAppendingString:@"medications/"] stringByAppendingString: drug_id] parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"drug: %@",  [responseObject description]);
        NSDictionary *drug_data = (NSDictionary *)responseObject;
        self.drug_name.text = drug_data[@"drug_name"];
        [self displayAndStyleDrugImage:self.drug[@"remote_drug_photo_url"] withImageView: self.drug_image withImageKeyName: @"remote_drug_photo_url"];
        self.adverse_events_arr = [drug_data[@"side_effects"] componentsSeparatedByString:@","];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
    }];
}
- (IBAction)report_action:(id)sender {
    [[AFNetwork getAFManager] POST:[SERVER_URL stringByAppendingString:@"adverse_event_reportings"] parameters:@{@"adverse_event_reporting": @{@"patient_id": [userDefaults valueForKey:@"patient_id"], @"drug_id": self.drug[@"drug_id"], @"side_effects": self.adverse_events.text}} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self showAlert:@"Report success" withMessage:@"Report success!"];
        self.adverse_events.text = @"";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)select_action:(id)sender {
    [self showNormalActionSheet:nil];
}

- (void)showNormalActionSheet:(id)sender {
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"What's your adverse event this time?"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:nil];
    for (NSString *title in self.adverse_events_arr) 
        [self.actionSheet addButtonWithTitle:title];
    self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
    [self.actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= [self.adverse_events_arr count]) {
        [actionSheet dismissWithClickedButtonIndex:4 animated:YES];
        return;
    }
    //handle the final array that for submitting
    [self.adverse_events_arr_for_submit addObject: self.adverse_events_arr[buttonIndex]];
    NSArray *uniq_adverse_events_arr = _.array(self.adverse_events_arr_for_submit).uniq.unwrap;
    self.adverse_events.text = [uniq_adverse_events_arr componentsJoinedByString:@","];
}

@end
