//
//  Drug.h
//  MyRxTracking
//
//  Created by Yu Song on 9/9/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manifest.h"

@interface Drug : NSObject
@property (strong, nonatomic) NSString *drug_name;
@property (strong, nonatomic) NSString *dosage;
@property (strong, nonatomic) NSMutableArray *side_effects;

+(NSMutableDictionary *)searchDrug: (NSString *)drug_name;
@end
