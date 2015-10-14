//
//  Coupon.m
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon
+(Coupon *)initWithProperties:(NSString *)name withImageView:(UIImageView *)imageView{
    Coupon *coupon = [[Coupon alloc] init];
    coupon.name = name;
    coupon.imageView = imageView;
    return coupon;
}
@end
