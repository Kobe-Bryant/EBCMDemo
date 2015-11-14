//
//  ChargeDetailVC.m
//  AHYDZF
//
//  Created by 王哲义 on 12-10-16.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import "ChargeDetailVC.h"

@interface ChargeDetailVC ()

@end

@implementation ChargeDetailVC


-(void)loadOtherFile:(NSString*)fileName andFormatter:(NSString*)hzm{
	
    NSRange range = [hzm rangeOfString:@"."];
    if (range.location != NSNotFound)
        hzm = [hzm stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *nameStr = [NSString stringWithFormat:@"%@.%@",fileName,hzm];
    NSString *path = [self shareFilePath:nameStr];
    NSURL *url = [NSURL fileURLWithPath:path isDirectory:NO];
    [myWebView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(NSString*)shareFilePath:(NSString*)filePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent: filePath];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    myWebView.scalesPageToFit = YES;
    
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


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark  webview delegate


- (void)dealloc {
    //	[webService release];
	[myWebView release];
    [super dealloc];
}

@end
