//
//  JFQKViewController.h
//  SZXQ
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "FPPopoverController.h"
#import "PaiKouTableViewController.h"

@interface PWSFViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,paiKouTableDelegate,NSURLConnHelperDelegate>{
    BOOL bHaveShow;
    FPPopoverController * popover;
    UIView * locationView;
    int curYearSelectTag;
    NSMutableArray * yearsArr;
}
@property (retain, nonatomic) IBOutlet UITextField *qymcF;
- (IBAction)searchClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *searchBut;
@property (retain, nonatomic) IBOutlet UILabel *qymcLb;
// 当前选择哪个模块
// 注意要和SegmentControl的index一致
//typedef enum {
//    JFQKModel = 0,  // 缴费情况
//    FPHZModel = 1   // 发票汇总
//} PWSFSubModel;
@property (nonatomic,strong) NSString * yearStr;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSURLConnHelper *urlConnHelper;
// 查询出来的结果
@property (nonatomic, strong) NSArray *resultArray;

@end
