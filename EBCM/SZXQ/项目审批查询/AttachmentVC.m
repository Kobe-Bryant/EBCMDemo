//
//  AttachmentVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AttachmentVC.h"
#import "ServiceUrlString.h"

@implementation AttachmentVC
@synthesize WJLJ,WJMC,HZ;
@synthesize webservice,gllx;

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
    self.title = WJMC;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"DOWN_OA_FILES" forKey:@"service"];
    [params setObject:WJLJ forKey:@"PATH"];
    [params setObject:gllx forKey:@"GLLX"];
    [params setObject:@"DOWN_FILE" forKey:@"ACTION_TYPE"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
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
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - URLConnHelper delegate

-(void)processWebData:(NSData*)webData
{
    if (webData == nil)
        return;
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@",WJMC,HZ];
    
    NSString* tmpDirectory  = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/"];
    NSString *tempFile = [tmpDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath: tempFile]) 
        [manager removeItemAtPath:tempFile error:NULL];
    
    NSURL *url = [NSURL fileURLWithPath:tempFile];
    [webData writeToURL:url atomically:NO];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebview loadRequest:request];
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
