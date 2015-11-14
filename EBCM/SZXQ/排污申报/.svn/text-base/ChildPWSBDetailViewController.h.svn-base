//
//  ChildPWSBDetailViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
@interface ChildPWSBDetailViewController : UIViewController<NSURLConnHelperDelegate>
@property(nonatomic,retain) IBOutlet UITableView *leftTableView;
@property(nonatomic,retain) IBOutlet UITableView *rightTableView;

@property(nonatomic,assign)NSInteger dataType;
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,copy) NSString *wrybh;
@property(nonatomic,assign) BOOL isFromWry;
@property(nonatomic,copy) NSString *monthYear;
@property(nonatomic,retain) NSMutableDictionary *dicData;
@property(nonatomic,retain) NSArray *aryOutName;

@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@end
