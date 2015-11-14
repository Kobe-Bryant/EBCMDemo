//
//  AttachmentVC.h
//  HNYDZF
//
//  Created by 王 哲义 on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"

@interface AttachmentVC : UIViewController <NSURLConnHelperDelegate>
{
    IBOutlet UIWebView *myWebview;
}

@property (nonatomic,copy) NSString *WJMC;
@property (nonatomic,copy) NSString *WJLJ;
@property (nonatomic,copy) NSString *HZ;
@property (nonatomic,copy) NSString *gllx;
@property (nonatomic,strong) NSURLConnHelper *webservice;

@end
