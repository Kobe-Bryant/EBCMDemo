//
//  PersonItem.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonItem.h"

@implementation PersonItem
@synthesize yhid,yhmc,bmbh,zfzh,bmmc;

- (PersonItem *)init
{
    self = [super init];
    if (self)
    {
        self.yhid = @"";
        self.yhmc = @"";
        self.bmbh = @"";
        self.zfzh = @"";
        self.bmmc = @"";
    }
    return self;
}

- (void)dealloc {
    [yhid release];
    [yhmc release];
    [bmbh release];
    [zfzh release];
    [bmmc release];
    [super dealloc];
}
@end
