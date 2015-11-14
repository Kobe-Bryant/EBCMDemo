//
//  PaiKouTableViewController.h
//  SZXQ
//
//  Created by ihumor on 12-11-28.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WURANYUANTYPE 2
#define CHOOSEYEAR    3
#define TJPORT        4
#define LZTJFJ        5

@protocol paiKouTableDelegate;

@interface PaiKouTableViewController : UITableViewController{
    
    NSArray * paiKouInfoArr;
    id <paiKouTableDelegate> delegage;
    int curTag;
    
}
@property (nonatomic) int curWuRanType;
@property (nonatomic,assign)id <paiKouTableDelegate> delegage;
- (id)initWithStyle:(UITableViewStyle)style AndInfoArr:(NSArray *)arr AndCurSelect:(int)curSelect;

@end

@protocol paiKouTableDelegate

-(void)didSelectPaiKou:(NSDictionary *)PaiKouDic AndCurSelect:(int)curtag;

@end
