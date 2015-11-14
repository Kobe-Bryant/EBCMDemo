//
//  WebserviceHelper.m
//  tesgt
//
//  Created by  on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSURLConnHelper.h"

@implementation NSURLConnHelper
@synthesize webData,delegate,HUD,mConnection;

- (NSURLConnHelper*)initWithUrl:(NSString *)aUrl 
                  andParentView:(UIView*)aView
                       delegate:(id)aDelegate{
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
        webData = [[NSMutableData alloc] initWithLength:100];
        //NSString *modifiedUrl = (NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)aUrl, nil, nil,kCFStringEncodingUTF8);//kCFStringEncodingGB_18030_2000 );// kCFStringEncodingUTF8

        
        NSURL *url = [NSURL URLWithString:aUrl];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData  timeoutInterval:40];
        self.mConnection = [NSURLConnection connectionWithRequest:request delegate:self];
        if (HUD) {
            [HUD release];
        }
        if (aView != nil) {
            HUD = [[MBProgressHUD alloc] initWithView:aView];
            [aView addSubview:HUD];
            
            HUD.labelText = @"正在请求数据，请稍候...";
            [HUD show:YES];
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        
    }
    return self;
    
}

-(void)cancel{
    if(mConnection) [mConnection cancel];
    if(HUD)  [HUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConnection");
    if(HUD) [HUD hide:YES];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [delegate processError:error] ;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(HUD)  [HUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [delegate processWebData:webData];
    [webData release];
}


@end
