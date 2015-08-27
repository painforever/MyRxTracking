
//
//  MedicationsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "MedicationsViewController.h"

@implementation MedicationsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Medications";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
- (IBAction)add_med_action:(id)sender {
    NewMedFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMedFormViewController"];
    [self.navigationController pushViewController:view animated:YES];
}
@end
