//
//  Coupon.h
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Coupon : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImageView *imageView;

+(Coupon *)initWithProperties: (NSString *)name withImageView: (UIImageView *)imageView;
@end
