//
//  SZMonitorViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 水站监测点

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#define WATERSTATION  0
#define AIRSTATION    1
#define NOISE         2
#define LDJC          3  //领导决策界面需要用的

@interface SZMonitorViewController : UIViewController<NSURLConnHelperDelegate>
@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property(nonatomic,strong)NSArray *returnAry;//获取到的json数据
@property(nonatomic) int type;
-(void)initScrollView;

@end
