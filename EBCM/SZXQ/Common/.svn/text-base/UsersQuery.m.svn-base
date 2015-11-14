//
//  UsersQuery.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UsersQuery.h"
#import "DBHelper.h"
#import "FMDatabase.h"
#import "DepartmentItem.h"
#import "PersonItem.h"

@implementation UsersQuery

+(NSArray*)queryPersonsByBMBH:(NSString*)bmbh{
   /* FMDatabase *db = [[DBHelper sharedInstance] getOpenedDataBase];
    NSMutableArray *ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    if(db){
        NSString *sql = [NSString stringWithFormat:@"SELECT * from T_ADMIN_RMS_YH where BMBH = \'%@\'",bmbh];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            PersonItem *aItem = [[PersonItem alloc] init];
            aItem.yhid = [rs stringForColumn:@"YHID"];
            aItem.yhmc = [rs stringForColumn:@"YHMC"];
            aItem.bmbh = [rs stringForColumn:@"BMBH"];
            aItem.zfzh = [rs stringForColumn:@"ZFZH"];
            [ary addObject:aItem];
            [aItem release];
        }
    }
    return ary;*/
    return nil;
}

+(NSArray*)queryChildDepartments:(NSString*)bmbh{
/*
    FMDatabase *db = [[DBHelper sharedInstance] getOpenedDataBase];
    NSMutableArray *ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    if(db){
        NSString *sql = [NSString stringWithFormat:@"SELECT * from T_ADMIN_RMS_ZZJG where SJZZXH= \'%@\'",bmbh];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            DepartmentItem *aItem = [[DepartmentItem alloc] init];
            aItem.BMBH = [rs stringForColumn:@"ZZBH"];
            aItem.BMMC = [rs stringForColumn:@"ZZJC"];
            aItem.parent = nil;
            [ary addObject:aItem];
            [aItem release];
        }
    }
    return ary;*/
    return nil;
}

@end
