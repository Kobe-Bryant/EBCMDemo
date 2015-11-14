//
//  SYXDetailVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SYXDetailVC.h"
#import "HtmlTableGenerator.h"
#import "ServiceType.h"
#import "JSONKit.h"

@implementation SYXDetailVC
@synthesize webservice,urlStr;


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (webservice)
        [webservice cancel];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    NSDictionary *resultDic = [resultJSON objectFromJSONString];
    if([resultDic objectForKey:@"columnNames"] !=nil){
        NSArray *aryTmp = [resultDic objectForKey:@"rows"];
        if (aryTmp && [aryTmp count] >0 ) {
            resultDic = [aryTmp objectAtIndex:0];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"提示" 
                                  message:@"请求数据失败,请检查网络连接并重试。" 
                                  delegate:self 
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
    }
    
    NSUInteger  serviceType = TYPE_QUERY_WRY_SYXDETAIL;
    NSString *htmlStr = [HtmlTableGenerator genContentWithTitle:@"试运行审批详情" andParaMeters:resultDic andType:serviceType];
    myWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [myWebView loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
}

-(void)processError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"提示" 
                          message:@"请求数据失败,请检查网络连接并重试。" 
                          delegate:self 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    return;
}

@end
