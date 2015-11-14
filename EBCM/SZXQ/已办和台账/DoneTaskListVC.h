//
//  DoneTaskListVC.h
//  HNMobileLaw
//
//  Created by 王 哲义 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDateViewController.h"
#import "NSURLConnHelper.h"

@interface DoneTaskListVC : UIViewController <UITableViewDelegate,UITableViewDataSource,NSURLConnHelperDelegate,PopupDateDelegate>

@property (nonatomic,strong) IBOutlet UITableView *listTable;
@property (nonatomic,strong) IBOutlet UILabel *businessLbl;
@property (nonatomic,strong) IBOutlet UILabel *startDateLbl;
@property (nonatomic,strong) IBOutlet UILabel *endDateLbl;
@property (nonatomic,strong) IBOutlet UITextField *businessField;
@property (nonatomic,strong) IBOutlet UITextField *startDateField;
@property (nonatomic,strong) IBOutlet UITextField *endDateField;
@property (nonatomic,strong) IBOutlet UIButton *searchBtn;
@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,strong) NSArray *resultAry;
@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,assign) int currentTag;
@property (nonatomic,assign) BOOL bHaveShow;
@property (nonatomic,strong) UIPopoverController *datePopover;
@property (nonatomic,strong) PopupDateViewController *dateSelectCtrl;

- (IBAction)searchBtnPressed:(id)sender;

@end
