
//
//  MyDoctorsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "MyDoctorsViewController.h"

@implementation MyDoctorsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Doctors";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
- (IBAction)add_new_doctor_action:(id)sender {
    NewDoctorViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDoctorViewController"];
    [self.navigationController pushViewController:view animated:YES];
}
@end
