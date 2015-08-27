//
//  SelfAlertsViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 8/26/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "SelfAlertsViewController.h"

@implementation SelfAlertsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"My Alerts";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
- (IBAction)add_alert_action:(id)sender {
    AlertFormViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertFormViewController"];
    [self.navigationController pushViewController:view animated:YES];
}
@end
