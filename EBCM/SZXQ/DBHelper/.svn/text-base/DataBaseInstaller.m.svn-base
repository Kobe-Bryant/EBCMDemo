//
//  DataBaseInstaller.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBaseInstaller.h"

@implementation DataBaseInstaller

+(void) Install{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dest = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    
    NSString *source = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data.db"];
    
    if(![fm fileExistsAtPath:source])
    {
        //NSLog(@"%@", @"数据库不存在");
        return;
    }
    if(![fm fileExistsAtPath:dest])
    {
        [fm copyItemAtPath:source toPath:dest error:nil];
    }
}

+ (void) replaceDB{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dest = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    
    
    NSString *source = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data.db"];
    
    if(![fm fileExistsAtPath:source])
    {
        //NSLog(@"%@", @"数据库不存在");
        return;
    }
    if([fm fileExistsAtPath:dest])
    {
        [fm removeItemAtPath:dest error:nil];//删除存在的文件
    }
    [fm copyItemAtPath:source toPath:dest error:nil];
    
    
}

@end
