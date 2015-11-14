//
//  QYDADetailVC.h
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface QYDADetailVC : UIViewController <NSURLConnHelperDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView * listTable;
    BOOL isGetList;//是否是获取附件
}

@property (retain, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,copy) NSString *wrybh;
@property (nonatomic,copy) NSString *wrymc;

//@property (nonatomic,strong)IBOutlet UITableView *myTableView;
@property(nonatomic,strong) NSArray *aryItems;

@end
