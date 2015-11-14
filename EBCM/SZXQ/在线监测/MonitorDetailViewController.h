//
//  MonitorDetailViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "S7GraphView.h"
#import "NSURLConnHelper.h"
#import "FPPopoverController.h"
#import "PaiKouTableViewController.h"
#import "AvailableDateListVC.h"

#define fswryTYPE 0
#define zjswryTYPE 1
#define wsclcTYPE  2
#define fqwryTYPE  3
#define yyjkTYPE   4
#define fsyTYPE    5
#define gfxtTYPE   6

@interface MonitorDetailViewController : UIViewController <NSURLConnHelperDelegate,UITableViewDelegate,UITableViewDataSource,S7GraphViewDataSource,UINavigationControllerDelegate,paiKouTableDelegate,AvailableDateDelegate>{
    FPPopoverController * popover;
    UIView * locationView;
     int curPaiKouSelect;
    NSArray * typeArr;
    NSArray * outputTypeArr;
    BOOL bDetailShow;
    BOOL getLatestDate;
}
@property (nonatomic,retain) UITableView *dataTableView;
@property (nonatomic,retain) UIWebView *resultWebView;
@property (nonatomic,strong) S7GraphView *graphView;
@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,strong) NSMutableString *html;
@property (nonatomic,strong) NSArray *valueAry;
@property (nonatomic,strong) NSMutableArray *keyAry;

@property(nonatomic,retain) NSArray *aItemInfo;
@property(nonatomic,retain) NSString *seldate;
@property (nonatomic,strong) UIViewController *childViewController;
@property (nonatomic,strong) UITableView *listTable;
@property (nonatomic) int wtype;
@property (nonatomic,copy) NSString * curKey;
@property (nonatomic,copy) NSString * qybh;
@property (nonatomic,copy) NSString * qymc;

@end
