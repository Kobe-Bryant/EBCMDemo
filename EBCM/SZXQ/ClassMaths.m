//
//  ClassMaths.m
//  SZXQ
//
//  Created by ihumor on 12-11-16.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "ClassMaths.h"

@implementation ClassMaths

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


@end
