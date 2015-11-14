//
//  xfDetailsViewController.m
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "xfDetailsViewController.h"
#import "ServiceUrlString.h"
#import "HtmlTableGenerator.h"
#import "ServiceType.h"
#import "JSONKit.h"
#import "xfMoreDetailViewController.h"

@implementation xfDetailsViewController
@synthesize wrybh,xh;
@synthesize urlConnHelper,dwmc;

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

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    NSArray * resultArr = [resultJSON objectFromJSONString];
    
    if(resultArr.count ==0){
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:@"请求数据失败..." 
                              delegate:self 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    NSDictionary * resultDic = [resultArr objectAtIndex:0];
    self.xfbh = [resultDic objectForKey:@"XFBH"];
    NSUInteger  serviceType = TYPE_QUERY_WRY_HJXF;
    NSString *htmlStr = [HtmlTableGenerator genContentWithTitle: @"信访详情" andParaMeters:resultDic andType:serviceType];
    webview.dataDetectorTypes = UIDataDetectorTypeNone;

    [webview loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
    
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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = dwmc;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"信访调查详情" style:UIBarButtonItemStyleBordered target:self action:@selector(moreDetailClick:)] autorelease];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WRY_HJXF" forKey:@"service"];
    [params setObject:wrybh forKey:@"wrybh"];
    [params setObject:xh forKey:@"xfbh"];
    [params setObject:@"json" forKey:@"dataType"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];

}

-(void)moreDetailClick:(id)sender{
    
    if (_xfbh ==nil||[_xfbh isEqualToString:@""]) {
        return;
    }
    xfMoreDetailViewController * moreDetail = [[xfMoreDetailViewController alloc] initWithNibName:@"xfMoreDetailViewController" bundle:nil];
    moreDetail.xfbh = _xfbh;
    [self.navigationController pushViewController:moreDetail animated:YES];
    [moreDetail release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    [super viewWillDisappear:animated];
}

-(void)dealloc
{
    [_xfbh release];
    [dwmc release];
    [webview release];
    [wrybh release];
    [xh release];
    [super dealloc];
}

#pragma mark -
#pragma mark  webview delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
   // [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;  
   // [self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];  
    
}


@end
