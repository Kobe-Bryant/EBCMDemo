//
//  PollutionSourceInfoViewController.h
//  EditingWord
//
//  Created by power humor on 12-6-26.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import <QuartzCore/QuartzCore.h>

@interface PollutionSourceInfoViewController : UIViewController<NSURLConnHelperDelegate,UIWebViewDelegate>
{
    int curChooseTag;
}
@property (nonatomic, strong) UIPopoverController *popController;

@property(nonatomic,strong)NSString *wrybh;     //从污染源列表得到编号
@property(nonatomic,strong)NSString *wrymc;     //从污染源列表得到名称
@property(nonatomic,assign)NSInteger serviceType;      //根据服务的不同，webview显示不同的数据

@property(nonatomic,strong) NSArray *aryMenus;
@property(nonatomic,strong)IBOutlet UIWebView *webview;
@property(nonatomic,strong)IBOutlet UITableView *menuTableView;

@property(nonatomic,strong)NSURLConnHelper  *urlConnHelper;
@property(nonatomic,strong)NSDictionary *wryInfoDic;

@end
