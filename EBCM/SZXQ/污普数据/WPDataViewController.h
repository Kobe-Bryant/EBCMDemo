//
//  WPDataViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 污普数据

#import <UIKit/UIKit.h>

@interface WPDataViewController : UIViewController
@property(nonatomic,copy) NSString *wrybh;
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,retain) IBOutlet UIWebView *webView;
@end
