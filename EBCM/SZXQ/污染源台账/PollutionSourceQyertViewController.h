//
//  PollutionSourceQyertViewController.h
//  EditingWord
//
//  Created by power humor on 12-6-25.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "CommenWordsViewController.h"

#define KChildQYDA 1 //是企业档案的入口

@interface PollutionSourceQyertViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnHelperDelegate,UIAlertViewDelegate,WordsDelegate,UITextFieldDelegate>

@property(nonatomic,strong) IBOutlet UITextField *WRYMC;
@property(nonatomic,strong) IBOutlet UITextField *WRYDZ;


@property(nonatomic,strong) IBOutlet UITextField *JGJB;


@property(nonatomic,strong) IBOutlet UILabel *wrymcLbl;
@property(nonatomic,strong) IBOutlet UILabel *wrydzLbl;


@property(nonatomic,strong) IBOutlet UILabel *jgjbLbl;

@property(nonatomic,strong) IBOutlet UIButton *searchBtn;
@property(nonatomic,strong) IBOutlet UITableView *myTableView;

@property(nonatomic,assign) int currentTag;
@property(nonatomic,assign) BOOL bHaveShow;

@property (nonatomic,strong) NSArray *levelCodeAry;
@property (nonatomic,copy) NSString *jgjbValue;

@property (nonatomic,strong) UIPopoverController *wordsPopover;
@property (nonatomic,strong) CommenWordsViewController *wordSelectCtrl;

@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property(nonatomic,strong)NSArray *returnAry;//获取到的json数据
@property(nonatomic,strong)NSArray *mainArray;
@property(nonatomic,strong)NSArray *subArray;
@property(nonatomic,assign) NSInteger childtype;//

-(IBAction)searchWry:(id)sender;//根据条件查询

@end
