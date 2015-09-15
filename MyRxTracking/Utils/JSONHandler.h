//
//  JSONHandler.h
//  new_green_box
//
//  Created by Yu on 12/6/14.
//  Copyright (c) 2014 Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface JSONHandler : NSObject
+(NSString*)DataToString:(NSData*)data;
+(NSData*)StringToData: (NSString*)str;
+(NSString *)ObjectToJSON: (id)obj;
+(NSString *)ConvertDictionaryToQueryString:(NSDictionary *)dic;
+(NSString *)ConvertBOOLToString: (BOOL)val;
+(NSMutableArray *)handleNilForArray: (NSData *)data;
+(NSMutableDictionary *)handleNilForHashs: (NSData *)data;
+(BOOL)isNnumber:(NSString *)input;

+(NSString *)microtime;
+(NSString *)md5: (NSString *)input;
@end

