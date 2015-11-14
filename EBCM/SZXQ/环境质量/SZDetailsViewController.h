//
//  SZDetailsViewController.h
//  SZXQ
//
//  Created by zhang on 12-11-28.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "S7GraphView.h"
#import "PopupDateViewController.h"
#define WATERSTATION  0
#define AIRSTATION    1
#define NOISE         2

@interface SZDetailsViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,S7GraphViewDataSource,PopupDateDelegate>{
    
    BOOL isGetDate;
}
@property(nonatomic,copy) NSString *pointCode;
@property(nonatomic,copy) NSString *pointName;
@property(nonatomic,copy) NSString *curType;
@end
