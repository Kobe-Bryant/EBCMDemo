//
//  UIChargeDetailController.h
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBWJItem.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface UIChargeDetailController : UIViewController<UIWebViewDelegate> 
@property(nonatomic,retain) UIWebView *webView;
@property(nonatomic,retain) ASINetworkQueue * networkQueue ;
@property(nonatomic,retain) IBOutlet UIProgressView *progress;
-(void)loadHtmlFile:(HBWJItem*)aItem;
@end
