//
//  ZrsUtil.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZrsUtil.h"
#import "UIDevice+IdentifierAddition.h"
@implementation ZrsUtil
+(NSString *)generateID{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];

    [fmt setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    // example: 2009-11-04T19:46:20.192723
    [fmt setDateFormat:@"yyyyMMddHH:mm:ss.SSSSSS"];
    NSString *dateStr = [fmt stringFromDate:date];
    [fmt release];
    
    NSString *uniquemac = [[UIDevice currentDevice] macaddress];
    NSString *str = [NSString stringWithFormat:@"%@%@",
                     uniquemac,dateStr];
    return str;
}

+(void)showAlertMsg:(NSString*)msg andDelegate:(id)delegate{

    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"提示" 
                          message:msg 
                          delegate:delegate 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    return;
}

+(CGFloat)calculateTextHeight:(NSString*) text byFontSize:(CGFloat)size
                     andWidth:(CGFloat)width{
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:size];
    
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    CGSize cellSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat cellHeight = cellSize.height + 40;
    
    if (cellHeight < 56)
        cellHeight = 56;
    
    return cellHeight;        
    
}

+(NSString *)makeDateStringWithDate:(NSDate *)date andFormatString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:str];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    return dateStr;
}

@end
