//
//  Coupon.m
//  MyRxTracking
//
//  Created by Yu Song on 10/14/15.
//  Copyright © 2015 EagleForce. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon
+(Coupon *)initWithProperties:(NSString *)brand_name withVendorName:(NSString *)vendor_name withNDC:(NSString *)ndc withExpirationDate:(NSString *)expiration_date withPercentDiscount:(NSString *)percent_discount withBIN:(NSString *)bin withPCN:(NSString *)pcn{
    Coupon *cp = [[Coupon alloc] init];
    cp.brand_name = brand_name;
    cp.vendor_name = vendor_name;
    cp.ndc = ndc;
    cp.expiration_date = expiration_date;
    cp.percent_discount = percent_discount;
    cp.bin = bin;
    cp.pcn = pcn;
    return cp;
}
@end
