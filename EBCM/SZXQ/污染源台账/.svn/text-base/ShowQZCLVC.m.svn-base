//
//  ShowQZCLVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowQZCLVC.h"
#import "ServiceUrlString.h"

@implementation ShowQZCLVC
@synthesize webservice,infoDic;
@synthesize imageView,myWebView;


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
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    [param setObject:@"DOWN_OA_FILES" forKey:@"service"];
    [param setObject:@"DOWN_FILE" forKey:@"ACTION_TYPE"];
    [param setObject:@"DOWNLOAD_XCQZ_FILE" forKey:@"GLLX"];
    [param setObject:[infoDic objectForKey:@"XH"] forKey:@"XH"];
    [param setObject:[infoDic objectForKey:@"WJKZM"] forKey:@"WJKZM"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:param ignoreClientType:YES];
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
    
    if (myWebView)
        [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    [super viewWillDisappear:animated];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation ==UIInterfaceOrientationLandscapeRight) 
    {
        if (self.imageView)
            imageView.frame = CGRectMake(0, 0, 1024, 704);
        if (self.myWebView)
            myWebView.frame = CGRectMake(0, 0, 1024, 704);
    }
    else 
    {
        if (self.imageView)
            imageView.frame = CGRectMake(0, 0, 768, 960);
        if (self.myWebView)
            myWebView.frame = CGRectMake(0, 0, 768, 960);
    }
        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - URLConnHelper delegate

-(void)processWebData:(NSData*)webData
{
    NSString *fileName = [infoDic objectForKey:@"SZWJNBMC"];
    
    NSString* tmpDirectory  = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/"];
    NSString *tempFile = [tmpDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath: tempFile]) 
        [manager removeItemAtPath:tempFile error:NULL];
    
    NSURL *url = [NSURL fileURLWithPath:tempFile];
    [webData writeToURL:url atomically:NO];
    
    NSString *fileType = [infoDic objectForKey:@"WJKZM"];
    if ([fileType isEqualToString:@".jpg"]||[fileType isEqualToString:@".jpeg"])
    {
        UIImage *image = [UIImage imageWithContentsOfFile:tempFile];
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)]  autorelease];
        imageView.image = image;
        [self.view addSubview:imageView];
    }
    
    else
    {
        self.myWebView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
        [self.view addSubview:myWebView];;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:request];
    }
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
