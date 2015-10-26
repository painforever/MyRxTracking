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
@property (strong, nonatomic) NSString *brand_name;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString *vendor_name;
@property (strong, nonatomic) NSString *ndc;
@property (strong, nonatomic) NSString *expiration_date;
@property (strong, nonatomic) NSString *percent_discount;

//bin and pcn
@property (strong, nonatomic) NSString *bin;
@property (strong, nonatomic) NSString *pcn;

+(Coupon *)initWithProperties: (NSString *)brand_name withVendorName:(NSString *)vendor_name withNDC: (NSString *)ndc withExpirationDate: (NSString *)expiration_date withPercentDiscount: (NSString *)percent_discount withBIN:(NSString *)bin withPCN:(NSString *)pcn;
@end
