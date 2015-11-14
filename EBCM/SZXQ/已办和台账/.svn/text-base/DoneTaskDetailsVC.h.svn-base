//
//  DoneTaskDetailsVC.h
//  HNMobileLaw
//
//  Created by 王 哲义 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NSURLConnHelper.h"
#import "DoneRecordsListVC.h"
//#import "CyqzDataModel.h"

@interface DoneTaskDetailsVC : UIViewController <NSURLConnHelperDelegate,DoneRecordDelegate,UINavigationControllerDelegate>{
    
}

@property (nonatomic) BOOL isBaseInfo;
@property (nonatomic,copy) NSString *xczfbh;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) UIWebView *myWeb;
@property (nonatomic,strong) UITableView *listTable;
@property (nonatomic,assign) int recordStatus;
@property (nonatomic,strong) NSDictionary *resultDic;
@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,copy) NSString *currentBh;
@property (nonatomic,strong) UIViewController *detailController;
@property (nonatomic,assign) BOOL bDetailShow;
@property (nonatomic) BOOL isXCJCBL;//判断当前是是否是现场监察笔录

@property (nonatomic,strong) NSDictionary *mainDic;
//@property (nonatomic,strong) CyqzDataModel *forthModel;

@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *daweiMC;
@end
