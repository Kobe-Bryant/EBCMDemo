//
//  HandbookDocumentVC.h
//  HNYDZF
//
//  Created by 王哲义 on 12-12-12.
//
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#define PAGE_TYPE_NONE  10 //不是首页(ROOT)
#define PAGE_TYPE_FLFG  0 //@"法律法规"
#define PAGE_TYPE_HBBZ  1 //@"环保标准"
#define PAGE_TYPE_ZYZDS 2 //@"作业指导书"
#define PAGE_TYPE_WXHXP 4 //@"危险化学品"
#define PAGE_TYPE_YJGL  3 //@"应急管理"

@interface HandbookDocumentVC : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UISearchBar *_searchBar;
	IBOutlet UITableView *myTableView;
    sqlite3 *data_db;
}

@property(nonatomic,strong) NSMutableArray *allInfo;
@property (nonatomic,strong) NSMutableArray *searchAry;
@property(nonatomic,strong) NSArray *unsearchInfo;
@property(nonatomic,strong) NSNumber *firstPageType;

-(void)searchByFIDH:(NSString *)strFIDH root:(NSString *)rootMl;

@end
