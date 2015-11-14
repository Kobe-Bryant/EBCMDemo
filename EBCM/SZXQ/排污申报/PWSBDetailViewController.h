//
//  PWSBDetailViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface PWSBDetailViewController : UIViewController<NSURLConnHelperDelegate>
@property(nonatomic,retain) IBOutlet UITableView *resTableView;
@property(nonatomic,retain) IBOutlet UILabel *infoLabel;
@property(nonatomic,copy) NSString *factID;
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,copy) NSString *wrybh;
@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property(nonatomic,assign) BOOL isFromWry;
//isFromWry YES表示从污染源来看排污申报数据
//NO 表示从申报查询来看排污申报数据
@end
