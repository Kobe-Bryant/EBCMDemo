//
//  JFQKDetailViewController.m
//  SZXQ
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "JFQKDetailViewController.h"
#import "HtmlTableGenerator.h"

@interface JFQKDetailViewController ()

@end

@implementation JFQKDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@%@年排污收费情况",[_JFQKDetail objectForKey:@"a"],_curYearStr];
    [self requestData];
}

- (void)dealloc
{
    [_webView release];
    [_JFQKDetail release];
    [_curYearStr release];
    [super dealloc];
}

#pragma mark RequestData
- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"QUERY_WRY_PWSF" forKey:@"service"];
    [params setObject:[_JFQKDetail objectForKey:@"wrybh"] forKey:@"wrybh"];
    [params setObject:_curYearStr forKey:@"selectYear"];
    NSString *requestURL = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:requestURL
                                                 andParentView:self.view
                                                      delegate:self] autorelease];
}

#pragma mark URLConnHelperDelegate
- (void)processWebData:(NSData *)webData
{
    NSString *resultString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    [self.webView loadHTMLString:resultString baseURL:nil];
    [resultString release];
}

- (void)processError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"请求数据失败,请检查网络连接并重试。"
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
- (void)viewWillDisappear:(BOOL)animated
{
    if (self.urlConnHelper) {
        [self.urlConnHelper cancel];
        self.urlConnHelper.delegate = nil;
    }
    [super viewWillDisappear:animated];
}


@end
