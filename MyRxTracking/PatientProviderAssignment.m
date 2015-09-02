//
//  PatientProviderAssignment.m
//  MyRxTracking
//
//  Created by Yu Song on 9/2/15.
//  Copyright (c) 2015 EagleForce. All rights reserved.
//

#import "PatientProviderAssignment.h"

@implementation PatientProviderAssignment
+(NSDictionary*)constructParams:(NSString *)passed_patient_id withProviderNPI:(NSString *)provider_npi{
    return @{@"patient_provider_assignment": @{@"patient_id": passed_patient_id, @"provider_npi": provider_npi}};
}
@end
