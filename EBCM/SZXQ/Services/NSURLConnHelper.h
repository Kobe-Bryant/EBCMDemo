//
//  WebserviceHelper.h
//  tesgt
//
//  Created by  on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@protocol NSURLConnHelperDelegate
-(void)processWebData:(NSData*)webData;
@optional
-(void)processError:(NSError *)error;
@end


@interface NSURLConnHelper : NSObject <NSURLConnectionDelegate>
@property(nonatomic,retain) NSMutableData *webData;
@property(nonatomic,assign) id<NSURLConnHelperDelegate> delegate;

@property(nonatomic,retain)MBProgressHUD *HUD;
@property(nonatomic,retain)NSURLConnection *mConnection;
-(void)cancel;
- (NSURLConnHelper*)initWithUrl:(NSString *)aUrl 
                  andParentView:(UIView*)aView //aView==nil表示不显示等待画面
                       delegate:(id)aDelegate;
@end
