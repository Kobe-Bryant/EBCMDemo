    //
//  UIChargeDetailController.m
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIChargeDetailController.h"
#import "ServiceUrlString.h"

@implementation UIChargeDetailController
@synthesize webView,networkQueue,progress;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

//首先再Document/hbwj/文件夹下查找文件是否存在，如果不存在则先下载保存在对应的目录下，然后显示

-(void)loadHtmlFile:(HBWJItem*)aItem{
	
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //NSString *paths1 = NSTemporaryDirectory();
    //NSLog(@"%@",paths1);
    NSString *filePath = [NSString stringWithFormat:@"%@/hbwj/",documentsDirectory];;
    NSString *dir = aItem.WJLJ;
    NSString *htmlName = aItem.WJMC;
    NSString *dest = @"";
    if(dir == nil || [dir isEqualToString:@""] || [dir isEqualToString:@"null"] || [[dir pathExtension] isEqualToString:@""]){
        
        if([aItem.HZ isEqualToString:@"null"])
            dest = [NSString stringWithFormat:@"%@%@",filePath,htmlName];
        else
            dest = [NSString stringWithFormat:@"%@%@%@",filePath,htmlName,aItem.HZ];
    }
    else{ 

        dest = [NSString stringWithFormat:@"%@%@",filePath,aItem.WJMC];
    }
    
    if([fm fileExistsAtPath:dest]){
        self.webView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
        [self.view addSubview:webView];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.dataDetectorTypes = UIDataDetectorTypeNone;
        
        if ([aItem.HZ isEqualToString:@".HTM"]
            || [[dest pathExtension] isEqualToString:@"html"]) {
            NSString *str = [NSString stringWithContentsOfFile:dest encoding:NSUTF8StringEncoding error:nil];
            if(str == nil){
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                str = [NSString stringWithContentsOfFile:dest encoding:enc error:nil];
            }
            [webView loadHTMLString:str baseURL:nil];
        }
        else{
            NSURL *url = [NSURL fileURLWithPath:dest isDirectory:NO];
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }
    else {
        
        [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
        [params setObject:@"DOWN_OA_FILES" forKey:@"service"];
        [params setObject:aItem.WJMC forKey:@"WJMC"];
        [params setObject:aItem.WJLJ forKey:@"WJLJ"];
        [params setObject:aItem.HZ forKey:@"HZ"];
        [params setObject:@"WZHBSC_Download" forKey:@"AccessPage"];
        [params setObject:@"DOWN_FILE" forKey:@"ACTION_TYPE"];
        NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
        
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
        request = [ ASIHTTPRequest requestWithURL :[ NSURL URLWithString :strUrl]]; // 设置文件 1 的 url
        [request setDownloadProgressDelegate : progress ]; // 文件 1 的下载进度条
        [request setDownloadDestinationPath:dest];

        // 使用 complete 块，在下载完时做一些事情
        [request setCompletionBlock :^( void ){
            self.webView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
            webView.scalesPageToFit = YES;
            webView.delegate = self;
            [self.view addSubview:webView];
            if ([aItem.HZ isEqualToString:@".HTM"]
                || [[dest pathExtension] isEqualToString:@"html"]) {
                NSString *str = [NSString stringWithContentsOfFile:dest encoding:NSUTF8StringEncoding error:nil];
                if(str == nil){
                    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                    str = [NSString stringWithContentsOfFile:dest encoding:enc error:nil];
                }
                [webView loadHTMLString:str baseURL:nil];
            }
            else{
                NSURL *url = [NSURL fileURLWithPath:dest isDirectory:NO];
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
                
            }
            
        }];
        // 使用 failed 块，在下载失败时做一些事情
        [request setFailedBlock :^( void ){
            NSLog ( @"download failed !");}
         ];
        
        
        [ networkQueue addOperation :request];
        [ networkQueue go ]; // 队列任务开始
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-(void)viewWillDisappear:(BOOL)animated{
    if(networkQueue)
        [networkQueue cancelAllOperations];
    [super viewWillDisappear:animated];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    self.progress = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark  webview delegate
/*
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;  
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '180%'"];  
}
*/

- (void)dealloc {
	[webView release];
	[networkQueue release];
    [progress release];
    
    [super dealloc];
}


@end
