//
//  WPDataViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPDataViewController.h"
#import "ServiceUrlString.h"

@interface WPDataViewController ()

@end

@implementation WPDataViewController
@synthesize wrybh,webView,wrymc;

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
     NSMutableDictionary *serviceParams = [NSMutableDictionary dictionaryWithCapacity:5];
    [serviceParams setObject:@"QUERY_WRYPC_BASE" forKey:@"service"];
    [serviceParams setObject:wrybh forKey:@"wrybh"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:serviceParams ignoreClientType:YES];
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    webView.scalesPageToFit = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    
    // Do any additional setup after loading the view from its nib.
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
