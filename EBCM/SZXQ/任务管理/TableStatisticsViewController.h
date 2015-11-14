//
//  TableStatisticsViewController.h
//  SZXQ
//
//  Created by ihumor on 12-12-29.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "PopupDateViewController.h"

#import "FPPopoverController.h"
#import "PaiKouTableViewController.h"

#define QJRWTJ       0
#define MBRW         1
#define LZRB         2
#define LZZB         3
#define LZYB         4
#define LZNB         5
#define JSXMSPTJ     6
#define JSXMHBTSTJ   7
#define PWSFTJ       8
#define SFPWLTJ      9
#define HJXFJCTJ     10
#define HJXFJDTJ     11
#define PWXKZTJ      12
#define QQFSYTJ      13
#define WFZYSPTJ     14 
#define DZFWCJTJ     15
#define JCZHPYSTJ    16
#define JCZXMWCTJ    17
#define JCXZTJ       18
#define YDZFTJ       19
#define GRZFTJ       20
#define AJDZFTJ      21



@interface TableStatisticsViewController : UIViewController<NSURLConnHelperDelegate,PopupDateDelegate,UITextFieldDelegate,paiKouTableDelegate,UITableViewDataSource,UITableViewDelegate>{
    
   
    BOOL bHaveShow;
    int currentTag;
    FPPopoverController * popover;
    UIView * locationView;
    int curYearSelectTag;
    NSMutableArray * yearsArr;
    BOOL isGetPort;
    int   curTJType;
}
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UIView *hisgramView;
- (IBAction)selectDate:(id)sender;
@property (copy,nonatomic) NSString *yearStr;
@property (retain, nonatomic) IBOutlet UILabel *endlb;
@property (retain, nonatomic) IBOutlet UITextField *endF;
@property (retain, nonatomic) IBOutlet UIButton *searchBut;
- (IBAction)searchButClick:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *startlb;
@property (retain, nonatomic) IBOutlet UITextField *startF;

@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic) int aIndex;
@property (nonatomic) int page;

@property (nonatomic,strong) UIPopoverController *datePopover;
@property (nonatomic,strong) PopupDateViewController *dateSelectCtrl;

@end
