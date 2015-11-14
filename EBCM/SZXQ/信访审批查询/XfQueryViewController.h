//
//  XfQueryViewController.h
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "PopupDateViewController.h"

@interface XfQueryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSURLConnHelperDelegate,PopupDateDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *btsrmc;
    IBOutlet UITextField *tsrxm;
    IBOutlet UITextField *ksspsj;
    IBOutlet UITextField *jsspsj;
    
    IBOutlet UILabel *btsrmcLbl;
    IBOutlet UILabel *tsrxmLbl;
    IBOutlet UILabel *ksspsjLbl;
    IBOutlet UILabel *jsspsjLbl;
    
    IBOutlet UIButton *searchBtn;
    IBOutlet UITableView *listTable;
}

@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property(nonatomic,strong)NSArray *resultAry;
@property(nonatomic,assign) int currentTag;
@property(nonatomic,assign) BOOL bHaveShow;
@property(nonatomic,copy) NSString *wrybh;
@property(nonatomic,copy) NSString *wrymc;
@property (nonatomic,strong) UIPopoverController *datePopover;
@property (nonatomic,strong) PopupDateViewController *dateSelectCtrl;

-(IBAction)searchButtonPressed:(id)sender;//根据条件查询

@end
