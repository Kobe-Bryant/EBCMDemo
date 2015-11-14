//
//  HBWJItem.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HBWJItem.h"

@implementation HBWJItem
@synthesize FGBH,FGMC,WJMC,FIDH,WJLJ,SFML,HZ;
-(void)dealloc{
    [FGBH release];
    [FGMC release];
    [WJMC release];
    [FIDH release];
    [WJLJ release];
    [SFML release];
    [HZ release];
    [super dealloc];
}
@end
