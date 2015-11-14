//
//  MenuItem.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem
@synthesize imgName;
@synthesize title;
@synthesize key;
@synthesize className;

- (void)dealloc {
    [imgName release];
    [title release];
    [key release];
    [className release];
    
    [super dealloc];
}

@end
