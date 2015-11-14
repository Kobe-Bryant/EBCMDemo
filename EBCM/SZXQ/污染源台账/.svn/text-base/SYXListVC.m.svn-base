//
//  SYXListVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SYXListVC.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "ZrsUtil.h"
#import "UITableViewCell+Custom.h"
#import "SYXDetailVC.h"

@implementation SYXListVC
@synthesize webservice;
@synthesize wrybh,wrymc;
@synthesize resultAry;

#define SYX 1

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    self.resultAry = [NSArray array];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setValue:@"QUERY_WRY_SYX" forKey:@"service"];
    [params setValue:wrybh forKey:@"wrybh"];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.webservice  = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (webservice)
        [webservice cancel];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *resultDic = [resultJSON objectFromJSONString];
    
    if (resultDic && [resultDic count] > 0)
    {
        self.resultAry  = [resultDic objectForKey:@"data"];
        
        if (resultAry && [resultAry count])
            [self.tableView reloadData];
        else
            [ZrsUtil showAlertMsg:@"获取的列表为空，没有符合条件的数据" andDelegate:nil];
    }
    else
        [ZrsUtil showAlertMsg:@"系统异常，请检查后台" andDelegate:nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [resultAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDic = [resultAry objectAtIndex:indexPath.row];
    
    NSString *time = [tmpDic objectForKey:@"SPRQ"];
    if ([time length] > 10)
    {
        time = [time substringToIndex:10];
    }
    NSString *sprStr = [tmpDic objectForKey:@"SPR"];
    NSString *sqrStr = [tmpDic objectForKey:@"SQR"];
    NSString *sftyStr = [tmpDic objectForKey:@"SFTY"];
    if ([sftyStr isEqualToString:@"1"])
        sftyStr = @"同意";
    else
        sftyStr = @"不同意";
    
    UITableViewCell *cell = [UITableViewCell makeSubCell:tableView withTitle:[tmpDic objectForKey:@"XMMC"] andSubvalue1:[NSString stringWithFormat:@"审批人:%@",sprStr] andSubvalue2:[NSString stringWithFormat:@"审批日期:%@",time] andSubvalue3:[NSString stringWithFormat:@"申请人:%@",sqrStr] andSubvalue4:sftyStr];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDic = [resultAry objectAtIndex:indexPath.row];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithCapacity:5];
    [paramDic setObject:@"QUERY_WRY_SYXDETAIL" forKey:@"service"];
    [paramDic setObject:[tmpDic objectForKey:@"SSCBH"] forKey:@"sscbh"];
    [paramDic setObject:[tmpDic objectForKey:@"XMBH"] forKey:@"xmbh"];
    NSString *urlString = [ServiceUrlString generateUrlByParameters:paramDic];
    
    SYXDetailVC *childVC = [[[SYXDetailVC alloc] initWithNibName:@"SYXDetailVC" bundle:nil] autorelease];
    childVC.urlStr = urlString;
    childVC.title = @"试运行审批详情";
    [self.navigationController pushViewController:childVC animated:YES];
}

@end
