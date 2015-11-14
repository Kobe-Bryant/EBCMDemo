//
//  LoginedUsrInfo.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  Singleton模式获取登录用户的信息，只能实例化一个

#import <Foundation/Foundation.h>

@interface LoginedUsrInfo : NSObject
+ (LoginedUsrInfo *) sharedInstance;
@property (copy,nonatomic) NSString *usr;
@property (copy,nonatomic) NSString *pwd;
@property (copy,nonatomic) NSString *BMBH;
@property (copy,nonatomic) NSString *YHMC;
@property (copy,nonatomic) NSArray *aryMenus;//该用户对应的菜单权限
@end
