//
//  DoneRecordsListVC.h
//  HNMobileLaw
//
//  Created by 王 哲义 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@protocol DoneRecordDelegate <NSObject>
- (void)returnRecordDictionary:(NSDictionary *)infoDic andStatus:(NSInteger)type;

@end


@interface DoneRecordsListVC : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
    
}

@property (nonatomic) BOOL isBaseInfo;
@property (nonatomic,strong) UITableView *recordTable;

@property (nonatomic,copy) NSString *urlStr;
@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,strong) NSMutableArray *recordAry;
@property (nonatomic,assign) id<DoneRecordDelegate> delegate; 

@property (nonatomic) int xcjcbl_count;
@property (nonatomic) int xccyjl_count;
@property (nonatomic) int xzcl_count;
@property (nonatomic) int laspb_count;
@property (nonatomic) int xwbl_count;
@property (nonatomic) int fjgl_count;
@property (nonatomic) int yjtzd_count;
@property (nonatomic) int xzjys_count;
@property (nonatomic) int xztss_count;
@property (nonatomic) int xzjss_count;
@property (nonatomic) int xzjcs_count;
@property (nonatomic) int cfajhfb_count;
@property (nonatomic) int xzjshfb_count;
@property (nonatomic) int hjjcyjs_count;
@property (nonatomic) int zdxmxzfds_count;
@property (nonatomic) int gpdb_count;
@property (nonatomic) int hjwfxwlaspb_count;
@property (nonatomic) int xzcfyjs_count;
@property (nonatomic) BOOL select;

@property (nonatomic) int ztzg_count;
@property (nonatomic) int swrfz_count;
@property (nonatomic) int fqwrfz_count;
@property (nonatomic) int wxpcfjgfwrfz_count;
@property (nonatomic) int zswrfz_count;

@property (nonatomic,copy) NSString *xczfbh;

@property (nonatomic,assign) int type;
@property (nonatomic,retain) NSMutableArray * leftTableInfoArr;

@end
