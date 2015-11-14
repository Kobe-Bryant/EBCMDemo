//
//  xfDetailsViewController.h
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface xfDetailsViewController : UIViewController<NSURLConnHelperDelegate,UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
}
@property(nonatomic,strong)NSString *wrybh;
@property(nonatomic,strong)NSString *xh;
@property(nonatomic,strong)NSURLConnHelper *urlConnHelper;
@property (copy,nonatomic) NSString * dwmc;
@property (copy,nonatomic) NSString * xfbh;

@end
