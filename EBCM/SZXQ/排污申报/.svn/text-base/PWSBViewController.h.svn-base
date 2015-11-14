//
//  PWSBViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 排污申报

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface PWSBViewController : UIViewController<NSURLConnHelperDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;


@property(nonatomic,strong)NSArray *returnAry;//获取到的json数据

@property(nonatomic,retain) IBOutlet UILabel *wrymcLabel;
@property(nonatomic,retain) IBOutlet UILabel *sfzxLabel;
@property(nonatomic,retain) IBOutlet UILabel *jgjbLabel;
@property(nonatomic,retain) IBOutlet UILabel *dwdzLabel;
@property(nonatomic,retain)IBOutlet UITableView *resTableView;
@property(nonatomic,retain)IBOutlet UITextField *wrymcField;
@property(nonatomic,retain)IBOutlet UITextField *wrydzField;

@property(nonatomic,retain)IBOutlet UISegmentedControl *hbjgjbSegCtrl;//环保监管级别
@property(nonatomic,retain)IBOutlet UISegmentedControl *sfzxSegCtrl;//是否注销

@property(nonatomic,retain) IBOutlet UIButton *btnSearch;
@property(nonatomic,assign) BOOL bHaveShow;
-(IBAction)btnSearch:(id)sender;
@end
