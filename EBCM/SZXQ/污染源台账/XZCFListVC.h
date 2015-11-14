//
//  XZCFListVC.h
//  HNYDZF
//
//  Created by 王 哲义 on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface XZCFListVC : UITableViewController <NSURLConnHelperDelegate>

@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,copy) NSString *wrybh;
@property (nonatomic,copy) NSString *wrymc;
@property (nonatomic,copy) NSString *urlStr;
@property (nonatomic,strong) NSArray *resultAry;

@end
