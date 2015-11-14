//
//  DBHelper.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabaseQueue.h"
#import "DepartmentItem.h"
#import "PersonItem.h"
#import "HBWJItem.h"

@interface DBHelper()
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;
@property(nonatomic,assign) BOOL isDbOpening;
@end

@implementation DBHelper
@synthesize dbQueue,isDbOpening;

static DBHelper *_sharedSingleton = nil;
+ (DBHelper *) sharedInstance
{
    @synchronized(self)
    {
        if(_sharedSingleton == nil)
        {
            _sharedSingleton = [NSAllocateObject([self class], 0, NULL) init];
            
        }
    }
    
    return _sharedSingleton;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax; // denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id) autorelease
{
    return self;
}

-(BOOL)initDataBaseQueue{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.db"];
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];;

    isDbOpening = YES;
    return YES;
    
}


-(void)initialAllTables{
    
	
}


-(NSString*)queryLastSyncTimeByTable:(NSString*)table{
    NSString *__block result = @"2000-01-01 10:00:00";//如果查找不到更新时间，就用这个时间
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT ifnull(MAX(XGSJ),'') as LASTSYNC FROM  %@",table];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            result = [rs stringForColumn:@"LASTSYNC"];
        }
    }];
    

    if([result isEqualToString:@""])
        result = @"2000-01-01 10:00:00";
    return result;
}

-(void)insertTable:(NSString*)tableName andDatas:(NSArray*)aryItems{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    if(aryItems == nil || [aryItems count] == 0 )
        return;
    NSMutableString *sqlstr = [NSMutableString stringWithCapacity:100];
    NSMutableString *fieldStr = [NSMutableString stringWithCapacity:50];
    NSMutableString *valueStr = [NSMutableString stringWithCapacity:50];
    
    for(NSDictionary *dic in aryItems){
        
        NSArray *aryKeys = [dic allKeys];
        //NSInteger *fieldCount = [aryKeys count];
        for(NSString *field in aryKeys){
            [fieldStr appendFormat:@"%@,",field];
            [valueStr appendFormat:@"'%@',",[dic objectForKey:field]];
        }


        [sqlstr appendFormat:@"insert into %@(%@) values(%@)",tableName,[fieldStr substringToIndex:([fieldStr length]-1)],[valueStr substringToIndex:([valueStr length]-1)]];
        [dbQueue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:sqlstr];
        }];
        
        [fieldStr setString:@""];
        [valueStr setString:@""];
        [sqlstr setString:@""];
    
    }

    
}

-(NSArray*)queryPersonsByBMBH:(NSString*)bmbh{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
     NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT table1.YHID,table1.YHMC,table1.BMBH,table1.ZFZH,table2.ZZJC from T_ADMIN_RMS_YH as table1 ,T_ADMIN_RMS_ZZJG as table2 where table1.BMBH = table2.ZZBH  and  table1.BMBH = \'%@\'",bmbh];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            PersonItem *aItem = [[PersonItem alloc] init];
            aItem.yhid = [rs stringForColumn:@"YHID"];
            aItem.yhmc = [rs stringForColumn:@"YHMC"];
            aItem.bmbh = [rs stringForColumn:@"BMBH"];
            aItem.zfzh = [rs stringForColumn:@"ZFZH"];
            aItem.bmmc = [rs stringForColumn:@"ZZJC"];
            [ary addObject:aItem];
            [aItem release];
        }
    }];
    
     return ary;
}

-(NSArray*)queryChildDepartments:(NSString*)bmbh{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT ZZBH, ZZJC from T_ADMIN_RMS_ZZJG where SJZZXH= \'%@\'",bmbh];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            DepartmentItem *aItem = [[DepartmentItem alloc] init];
            aItem.BMBH = [rs stringForColumn:@"ZZBH"];
            aItem.BMMC = [rs stringForColumn:@"ZZJC"];
            aItem.parent = nil;
            [ary addObject:aItem];
            [aItem release];
        }
    }];
    
    return ary;
}

-(NSArray*)queryHBWJItemsByFIDH:(NSString*)fidh{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT FGBH,FGMC,WJMC,FIDH,WJLJ,SFML,HZ FROM T_YDZF_FLFG WHERE FIDH=  \'%@\' order by PXM",fidh];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            HBWJItem *aItem = [[HBWJItem alloc] init];
            aItem.FGBH = [rs stringForColumn:@"FGBH"];
            aItem.FGMC = [rs stringForColumn:@"FGMC"];
            aItem.WJMC = [rs stringForColumn:@"WJMC"];
            aItem.FIDH = [rs stringForColumn:@"FIDH"];
            aItem.WJLJ = [rs stringForColumn:@"WJLJ"];
            aItem.SFML = [rs stringForColumn:@"SFML"];
            aItem.HZ = [rs stringForColumn:@"HZ"];
            
            [ary addObject:aItem];
            [aItem release];
        }
    }];
    
    return ary;
}

-(NSArray*)queryWJMCItemsByStr:(NSString*)inputStr
{
    if (isDbOpening == NO)
        [self initDataBaseQueue];
    
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
    NSString *sql = [NSString stringWithFormat:@"SELECT FGBH,FGMC,WJMC,FIDH,WJLJ,SFML,HZ FROM T_YDZF_FLFG WHERE FGMC LIKE \'%%%@%%\' OR WJMC LIKE \'%%%@%%\' order by PXM", inputStr,inputStr];
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            HBWJItem *aItem = [[HBWJItem alloc] init];
            aItem.FGBH = [rs stringForColumn:@"FGBH"];
            aItem.FGMC = [rs stringForColumn:@"FGMC"];
            aItem.WJMC = [rs stringForColumn:@"WJMC"];
            aItem.FIDH = [rs stringForColumn:@"FIDH"];
            aItem.WJLJ = [rs stringForColumn:@"WJLJ"];
            aItem.SFML = [rs stringForColumn:@"SFML"];
            aItem.HZ = [rs stringForColumn:@"HZ"];
            
            [ary addObject:aItem];
            [aItem release];
        }
    }];
    
    return ary;
}

@end
