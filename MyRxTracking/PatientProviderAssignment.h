//
//  PatientProviderAssignment.h
//  MyRxTracking
//
//  Created by Yu Song on 9/2/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientProviderAssignment : NSObject
+(NSDictionary *)constructParams: (NSString *)passed_patient_id withProviderNPI: (NSString*)provider_npi;
@end
