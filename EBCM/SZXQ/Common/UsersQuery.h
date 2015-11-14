//
//  UsersQuery.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersQuery : NSObject

+(NSArray*)queryPersonsByBMBH:(NSString*)bmbh;

+(NSArray*)queryChildDepartments:(NSString*)bmbh;

@end

