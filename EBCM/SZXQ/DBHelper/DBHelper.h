//
//  DBHelper.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBHelper : NSObject
+ (DBHelper *) sharedInstance;

-(void)initialAllTables;
//获取数据库表的最后更新时间
-(NSString*)queryLastSyncTimeByTable:(NSString*)table;
//插入数据到本地数据库
-(void)insertTable:(NSString*)tableName andDatas:(NSArray*)aryItems; 



-(NSArray*)queryPersonsByBMBH:(NSString*)bmbh;

-(NSArray*)queryChildDepartments:(NSString*)bmbh;

-(NSArray*)queryHBWJItemsByFIDH:(NSString*)fidh;

-(NSArray*)queryWJMCItemsByStr:(NSString*)inputStr;

@end
