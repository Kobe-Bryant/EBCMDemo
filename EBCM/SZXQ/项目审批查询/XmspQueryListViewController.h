//
//  XmspQueryListViewController.h
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "PopupDateViewController.h"
#import "FPPopoverController.h"
#import "PaiKouTableViewController.h"

@interface XmspQueryListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSURLConnHelperDelegate,PopupDateDelegate,UITextFieldDelegate,paiKouTableDelegate>
{
    IBOutlet UITextField *xmbh;
    IBOutlet UITextField *xmmc;
    IBOutlet UITextField *tzdw;
    IBOutlet UITextField *ksspsj;
    IBOutlet UITextField *jsspsj;
    FPPopoverController * popover;
    int curYearSelectTag;
    NSMutableArray * yearsArr;
    
    IBOutlet UILabel *xmbhLbl;
    IBOutlet UILabel *xmmcLbl;
    IBOutlet UILabel *tzdwLbl;
    IBOutlet UILabel *ksspsjLbl;
    IBOutlet UILabel *jsspsjLbl;
    
    IBOutlet UIButton *searchBtn;
    IBOutlet UITableView *listTable;
}
- (IBAction)chooseXMYear:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *haoLb;
@property (retain, nonatomic) IBOutlet UITextField *numF;
@property (retain, nonatomic) IBOutlet UILabel *rightlb;
@property (retain, nonatomic) IBOutlet UITextField *yearF;
@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property(nonatomic,strong)NSArray *resultAry;

@property (retain, nonatomic) IBOutlet UILabel *leftlb;
@property(nonatomic,assign) int currentTag;
@property(nonatomic,assign) BOOL bHaveShow;
@property(nonatomic,copy) NSString *wrybh;
@property(nonatomic,copy) NSString *wrymc;
@property (nonatomic,strong) UIPopoverController *datePopover;
@property (nonatomic,strong) PopupDateViewController *dateSelectCtrl;

-(IBAction)searchButtonPressed:(id)sender;//根据条件查询
@end
