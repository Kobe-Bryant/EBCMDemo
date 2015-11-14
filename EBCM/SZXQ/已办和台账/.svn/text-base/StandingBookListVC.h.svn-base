//
//  StandingBookListVC.h
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDateViewController.h"
#import "NSURLConnHelper.h"
#import "CommenWordsViewController.h"

@interface StandingBookListVC : UIViewController <UITableViewDelegate,UITableViewDataSource,NSURLConnHelperDelegate,PopupDateDelegate>

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
@property (nonatomic,assign) BOOL bHaveShew;
@property (nonatomic,strong) UIPopoverController *datePopover;
@property (nonatomic,strong) PopupDateViewController *dateSelectCtrl;
@property (nonatomic,strong) UIPopoverController *wordsPopover;
@property (nonatomic,strong) CommenWordsViewController *wordSelectCtrl;

@property (nonatomic,strong) NSArray *levelCodeAry;
@property (nonatomic,copy) NSString *jgjbValue;
@property (nonatomic,copy) NSString *ssdsValue; 
@property (nonatomic,strong)NSArray *mainArray;
@property (nonatomic,copy) NSString *qualityValue;

@property (nonatomic,assign) BOOL bAlone;
@property (nonatomic,copy) NSString *rwbhStr;
@property(nonatomic,copy) NSString *wrybh;
@property(nonatomic,copy) NSString *wrymc;
- (IBAction)searchBtnPressed:(id)sender;

@end
