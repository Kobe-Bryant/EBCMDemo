//
//  XCQZDetailVC.h
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface XCQZDetailVC : UIViewController <NSURLConnHelperDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *listTable;
}

@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,copy) NSString *wrybh;
@property (nonatomic,copy) NSString *wrymc;
@property (nonatomic,strong) NSArray *resultAry;
@property (nonatomic,assign) int serviceType;

@end
