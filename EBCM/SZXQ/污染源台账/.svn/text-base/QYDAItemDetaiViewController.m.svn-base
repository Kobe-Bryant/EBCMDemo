//
//  QYDAItemDetaiViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QYDAItemDetaiViewController.h"
#import "ServiceUrlString.h"

@interface QYDAItemDetaiViewController ()

@end

@implementation QYDAItemDetaiViewController
@synthesize filePath,webView,progress,networkQueue,label,infoDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadFile{
	
    NSString *urlStr = @"";
    if (_fjUrlStr !=nil ) {
        urlStr = _fjUrlStr;
    }
    else{
        NSMutableDictionary *serviceParams = [NSMutableDictionary dictionaryWithCapacity:5];
        //ACTION_TYPE=DOWN_FILE
        [serviceParams setObject:@"DOWN_OA_FILES" forKey:@"service"];
        [serviceParams setObject:@"FJXZ_Download" forKey:@"AccessPage"];
        [serviceParams setObject:[infoDic objectForKey:@"MC"] forKey:@"WJMC"];
        [serviceParams setObject:[infoDic objectForKey:@"LJ"] forKey:@"WJLJ"];
        [serviceParams setObject:[infoDic objectForKey:@"WRYBH"] forKey:@"WRYBH"];
        [serviceParams setObject:[infoDic objectForKey:@"GS"] forKey:@"HZ"];
        [serviceParams setObject:[infoDic objectForKey:@"DMJBH"] forKey:@"DMJBH"];
        [serviceParams setObject:@"DOWN_FILE" forKey:@"ACTION_TYPE"];
        
        urlStr = [ServiceUrlString generateUrlByParameters:serviceParams ignoreClientType:YES];
    }

    NSString *dest = [NSString stringWithFormat:@"%@tmp.%@",NSTemporaryDirectory(),[filePath pathExtension]];
    

        
        //////////////////////////// 任务队列 /////////////////////////////
        if (! networkQueue ) {
            self.networkQueue = [[[ ASINetworkQueue alloc ] init ] autorelease];
        }
        
        [ networkQueue reset ]; // 队列清零
        [ networkQueue setShowAccurateProgress : YES ]; // 进度精确显示
        // [networkQueue setDownloadProgressDelegate:progress];
        [ networkQueue setDelegate : self ]; // 设置队列的代理对象
        ASIHTTPRequest *request;
        
        ///////////////// request for file1 //////////////////////
        request = [ ASIHTTPRequest requestWithURL :[ NSURL URLWithString :urlStr]]; // 设置文件 1 的 url
        [request setDownloadProgressDelegate : progress ]; // 文件 1 的下载进度条
        [request setDownloadDestinationPath:dest];
        
        // 使用 complete 块，在下载完时做一些事情
        [request setCompletionBlock :^( void ){
            webView.hidden = NO;
            label.hidden = YES;
            progress.hidden = YES;
            NSURL *url = [[NSURL alloc] initFileURLWithPath:dest];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
            [url release];
         
        }];
        // 使用 failed 块，在下载失败时做一些事情
        [request setFailedBlock :^( void ){
            NSLog ( @"download failed !");}
         ];
        
        
        [ networkQueue addOperation :request];
        [ networkQueue go ]; // 队列任务开始
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webView.hidden = YES;
    [self loadFile];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if(networkQueue)
        [networkQueue cancelAllOperations];
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
