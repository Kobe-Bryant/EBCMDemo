//
//  HtmlTableGenerator.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HtmlTableGenerator.h"
#import "ServiceType.h"

@implementation HtmlTableGenerator

+(NSString*)genContentWithTitle:(NSString*)aTitle andParaMeters:(NSDictionary*)params
andType:(NSInteger)serviceType{
    
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json" ofType:@"plist"]];
    
    NSString *serviceKey = nil;
    switch (serviceType) {
        case TYPE_QUERY_WRY_INFO:
            serviceKey=@"QUERY_WRY_INFO";
            break;
        case TYPE_XMSP_DATA_DETAIL:
            serviceKey=@"XMSP_DATA_DETAIL";
            break;
        case TYPE_QUERY_WRY_SYXDETAIL:
            serviceKey=@"QUERY_WRY_SYXDETAIL";
            break;
        case TYPE_QUERY_WRY_PWXKZ:
            serviceKey=@"QUERY_WRY_PWXKZ";
            break;
        case TYPE_QUERY_WRY_HJXF:
            serviceKey=@"QUERY_WRY_HJXF";
            break;
        case TYPE_QUERY_WRY_XZCF_DETAIL:
            serviceKey=@"QUERY_WRY_XZCF_DETAIL";
            break;
        case TYPE_QUERY_WRY_YSDETAIL:
            serviceKey=@"QUERY_WRY_YSDETAIL";
            break;
        case TYPE_JCJL_RECORD:
            serviceKey=@"COMMIT_XCZF_QUERY_RECORD_COUNT";
            break;
        case TYPE_XCKC_RECORD:
            serviceKey=@"QUERY_XCZF_XCKC_INFO";
            break;
        case TYPE_DCXW_RECORD:
            serviceKey=@"QUERY_XCZF_XWBL_RECORD";
            break;
        case TYPE_QUERY_XCZF_TZ_BASE:
            serviceKey = @"QUERY_XCZF_TZ_BASE";
            break;
        case TYPE_QUERY_JFQK_DETAIL:
            serviceKey = @"QUERY_JFQK_DETAIL";
            break;
        case TYPE_QUERY_XCZF_TZ_XCJCBL:
            serviceKey = @"QUERY_XCZF_TZ_XCJCBL";//现场检查笔录
            break;
        default:
            break;
    }
 
    if(serviceKey == nil)return @"";
    NSDictionary * tmpDic = [configDic objectForKey:serviceKey];
    NSArray *aryKeys = [tmpDic objectForKey:@"keys"];
    NSArray *aryTypes = [tmpDic objectForKey:@"types"];
    
    NSMutableString *paramsStr = [NSMutableString stringWithCapacity:1500];
    int count = [aryKeys count];

    for (int i = 0; i < count; ) {
        NSString *key1 = [aryKeys objectAtIndex:i];
        NSNumber *keyType = [aryTypes objectAtIndex:i];
        
        if (i+1 < count) {
            NSNumber *nextKeyType = [aryTypes objectAtIndex:i+1];
            if([keyType intValue] == 2 && [nextKeyType intValue] == 2){
                NSString *key2 = [aryKeys objectAtIndex:i+1];
                NSString *value1 = [params objectForKey:key1];
                NSString *value2 = [params objectForKey:key2];
                if(value1 == nil)value1 = @"";
                if(value2 == nil)value2 = @"";
                [paramsStr appendFormat:@"<tr><td width=\"13%%\" class=\"t1\">%@</td><td  width=\"37%%\"  class=\"t2\">%@</td><td width=\"13%%\" class=\"t1\">%@</td><td width=\"37%%\"  class=\"t2\">%@</td></tr>",
                 [tmpDic objectForKey:key1],value1,[tmpDic objectForKey:key2],value2];
                i+=2;
                continue;
            }
        }        
        
        
        NSString *value = [params objectForKey:key1];
        if(value == nil)value = @"";
        [paramsStr appendFormat:@"<tr><td width=\"13%%\" class=\"t1\">%@</td><td colspan=\"3\" width=\"87%%\"  class=\"t2\">%@</td></tr>",
         [tmpDic objectForKey:key1],value];
        
        i += 1;
        
    }

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tablenew" ofType:@"htm"];

    NSMutableString *resultHtml = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [resultHtml appendString:aTitle];
    [resultHtml appendString:@"</h2><div class=\"tablemain\"><table width=\"100%%\" border=\"0\" cellspacing=\"1\"  cellpadding=\"0\" bgcolor=\"#caeaff\">"];
    [resultHtml appendString:paramsStr];
    [resultHtml appendString:@"</table></div></div></body></html>"];
    return resultHtml;
}

+(NSArray *)genContentWithParaMeters:(NSArray *)params andServiceType:(NSString *)serviceType{
    
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json" ofType:@"plist"]];
    
    NSDictionary * tmpDic = [configDic objectForKey:serviceType];
    NSArray *aryKeys = [tmpDic objectForKey:@"keys"];
    NSArray *aryName = [tmpDic objectForKey:@"name"];
    NSMutableArray *paramsArray = [NSMutableArray array];
    
    if (aryName.count == 0) {
        for (NSDictionary *dic in params) {
            NSMutableDictionary *valueDic = [NSMutableDictionary dictionary];
            [valueDic setObject:[dic objectForKey:[aryKeys objectAtIndex:0]] forKey:@"value"];
            [valueDic setObject:[dic objectForKey:[aryKeys objectAtIndex:1]] forKey:@"name"];
            [paramsArray addObject:valueDic];
        }
    }
    else{
        NSDictionary *paramsDic = [params objectAtIndex:0];
        for (int i=0; i<aryKeys.count; i++) {
            NSString *key = [aryKeys objectAtIndex:i];
            NSString *name = [aryName objectAtIndex:i];
            NSMutableDictionary *valueDic = [NSMutableDictionary dictionary];
            [valueDic setObject:[paramsDic objectForKey:key] forKey:@"value"];
            [valueDic setObject:name forKey:@"name"];
            [paramsArray addObject:valueDic];
        }
    }
    return paramsArray;
}


@end
