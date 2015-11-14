//
//  ServiceUrlString.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ServiceUrlString.h"
#import "LoginedUsrInfo.h"
#import "SettingsInfo.h"

@implementation ServiceUrlString
+(NSString*)generateUrlByParameters:(NSDictionary*)params{
    if(params == nil)return @"";
    NSArray *aryKeys = [params allKeys];
    if(aryKeys == nil)return @"";
    LoginedUsrInfo *usrInfo = [LoginedUsrInfo sharedInstance];
    SettingsInfo   *settings = [SettingsInfo sharedInstance];
    
    NSMutableString *paramsStr = [NSMutableString stringWithCapacity:100];
    for(NSString *str in aryKeys){
        [paramsStr appendFormat:@"&%@=%@",str,[params objectForKey:str]];
    }
    
    //    NSString *strUrl = [NSString stringWithFormat:@"http://%@/invoke/?version=%@&imei=%@&clientType=IPAD&userid=%@&password=%@%@",settings.ipHeader, settings.version, settings.uniqueDeviceID,usrInfo.usr,usrInfo.pwd, paramsStr];
    
    NSString *strUrl = [NSString stringWithFormat:@"http://%@/invoke?version=%@&imei=%@&clientType=IPAD&userid=%@&password=%@%@",settings.ipHeader, settings.version, settings.uniqueDeviceID,usrInfo.usr,usrInfo.pwd, paramsStr];
    
    NSString *modifiedUrl = (NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strUrl, nil, nil,kCFStringEncodingUTF8);
    
    return modifiedUrl;
}

+(NSString*)generateUrlByParameters:(NSDictionary*)params ignoreClientType:(BOOL)ignore{
    if(params == nil)return @"";
    NSArray *aryKeys = [params allKeys];
    if(aryKeys == nil)return @"";
    LoginedUsrInfo *usrInfo = [LoginedUsrInfo sharedInstance];
    SettingsInfo   *settings = [SettingsInfo sharedInstance];
    
    NSMutableString *paramsStr = [NSMutableString stringWithCapacity:100];
    for(NSString *str in aryKeys){
        [paramsStr appendFormat:@"&%@=%@",str,[params objectForKey:str]];
    }
    if(ignore == NO)
        [paramsStr appendString:@"&clientType=IPAD"];
    
//    NSString *strUrl = [NSString stringWithFormat:@"http://%@/invoke/?version=%@&imei=%@&userid=%@&password=%@%@",settings.ipHeader, settings.version, settings.uniqueDeviceID,usrInfo.usr,usrInfo.pwd, paramsStr];
     NSString *strUrl = [NSString stringWithFormat:@"http://%@/invoke?version=%@&imei=%@&userid=%@&password=%@%@",settings.ipHeader, settings.version,settings.uniqueDeviceID,usrInfo.usr,usrInfo.pwd, paramsStr];
    
    NSString *modifiedUrl = (NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)strUrl, nil, nil,kCFStringEncodingUTF8);
    
    return modifiedUrl;
}

@end
