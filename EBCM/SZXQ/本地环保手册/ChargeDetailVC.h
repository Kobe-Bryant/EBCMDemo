//
//  ChargeDetailVC.h
//  AHYDZF
//
//  Created by 王哲义 on 12-10-16.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeDetailVC : UIViewController {
    
    //	WebServiceHelper* webService;
	IBOutlet UIWebView *myWebView;
	
	NSMutableData *webData;
	NSMutableString *currentData;
    
}

-(void)loadOtherFile:(NSString*)fileName andFormatter:(NSString*)hzm;

@end
