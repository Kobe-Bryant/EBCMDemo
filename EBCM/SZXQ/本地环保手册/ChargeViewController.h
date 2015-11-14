//
//  ChargeViewController.h
//  AHYDZF
//
//  Created by 王哲义 on 12-10-16.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#define PAGE_TYPE_NONE  0 //不是首页(ROOT)
#define PAGE_TYPE_FLFG  1 //@"法律法规"
#define PAGE_TYPE_ZYZDS 2 //@"作业指导书"
#define PAGE_TYPE_NBZD  3 //@"内部管理制度"

@interface ChargeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    UISearchBar *_searchBar;
	IBOutlet UITableView *myTableView;
    sqlite3 *data_db;
    NSArray * nameArr;
    NSString *viewTitle;
}

@property (nonatomic,assign) BOOL bHtmlFile;
@property(nonatomic,strong) NSString *viewTitle;
@property(nonatomic,strong) UISearchBar *_searchBar;
@property(nonatomic,strong) NSMutableArray *allInfo;
@property (nonatomic,strong) NSMutableArray *searchAry;
@property(nonatomic,strong) NSArray *unsearchInfo;
@property(nonatomic,assign) NSInteger firstPageType; //首页显示的类型
@property (nonatomic,assign) BOOL isUTF8;
//-(void)searchByFIDH:(id)strFIDH;
-(void)getCurType:(NSString *)str;

@end
