//
//  ChartAndTableViewController.h
//  SZXQ
//
//  Created by ihumor on 13-5-13.
//  Copyright (c) 2013年 ihumor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "S7GraphView.h"
#import "NSURLConnHelper.h"

@interface ChartAndTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnHelperDelegate,S7GraphViewDataSource>
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property (nonatomic, retain) NSMutableArray *itemAry;
@property (nonatomic, retain) NSMutableArray *resultAry;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic,strong) S7GraphView *graphView;
-(void)requestData;
@end
