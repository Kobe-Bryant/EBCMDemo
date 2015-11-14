//
//  SettingsInfo.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsInfo : NSObject
+ (SettingsInfo *) sharedInstance;
-(void)readSettings;
@property (strong,nonatomic) NSString *uniqueDeviceID;
@property (strong,nonatomic) NSString *ipHeader;
@property (strong,nonatomic) NSString *version;
@property (assign,nonatomic) BOOL enableFilterMenu;//是否需要检查权限
@end
