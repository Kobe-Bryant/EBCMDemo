//
//  xfMoreDetailViewController.m
//  SZXQ
//
//  Created by ihumor on 12-12-27.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "xfMoreDetailViewController.h"
#import "ServiceUrlString.h"

@interface xfMoreDetailViewController ()

@end

@implementation xfMoreDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myWebView.scalesPageToFit = YES;
    if (_isMonitor) {
        self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:_detailUrl andParentView:self.view delegate:self] autorelease];
        return;
    }
    self.title = @"信访调查详情";
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WRY_HJXF_DC" forKey:@"service"];
    [params setObject:_xfbh forKey:@"xfbh"];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    self.myWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [_myWebView loadHTMLString:resultJSON baseURL:[[NSBundle mainBundle] bundleURL]];
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



- (void)viewWillDisappear:(BOOL)animated
{
    
    if (_urlConnHelper)
        [_urlConnHelper cancel];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_detailUrl release];
    [_xfbh release];
    [_myWebView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyWebView:nil];
    [super viewDidUnload];
}
@end
