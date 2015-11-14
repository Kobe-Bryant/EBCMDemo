//
//  MonitorViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
@interface MonitorViewController : UIViewController <NSURLConnHelperDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSArray * typeArr;
    IBOutlet UITableView *mytableView;
    BOOL isGetPK;
    NSString * curselectQYMC;
    NSString * curselectQYBH;
    NSArray * outputTypeArr;
   
}
@property(nonatomic)  int  wuranType;
@property(nonatomic)  int  isCancel;
@property(nonatomic,strong)NSURLConnHelper *webHelper;
@property(nonatomic,retain) NSArray *dataItems;
@property(nonatomic,retain) NSMutableArray *dataSave;

-(void)getCurType:(int)type;

@end
