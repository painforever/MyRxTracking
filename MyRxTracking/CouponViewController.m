//
//  CouponViewController.m
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "CouponViewController.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.frame.size.width-50, self.view.frame.size.height-500)];
    imageView.image = [UIImage imageNamed:@"eagleforce_logo.png"];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+10, self.view.bounds.origin.y+self.view.frame.size.height-500+10, 100, 30)];
    name.text = @"Yu Song";
    
    UILabel *pcn = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+10, self.view.bounds.origin.y+self.view.frame.size.height-500+50, 100, 30)];
    pcn.text = @"G434890802";
    [self.view addSubview:imageView];
    [self.view addSubview:name];
    [self.view addSubview:pcn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
