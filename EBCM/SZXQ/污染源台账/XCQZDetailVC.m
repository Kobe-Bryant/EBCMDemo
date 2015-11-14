//
//  XCQZDetailVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XCQZDetailVC.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "ZrsUtil.h"
#import "ShowQZCLVC.h"

@implementation XCQZDetailVC
@synthesize webservice,serviceType;
@synthesize wrybh,wrymc,resultAry;

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
    [param setObject:@"QUERY_WRY_PIC" forKey:@"service"];
    
    if (serviceType == 1)
    {
        [param setObject:wrybh forKey:@"wrybh"];
        [param setObject:@"40" forKey:@"queryType"];
    }
    else if (serviceType == 2)
    {
        [param setObject:wrymc forKey:@"wrymc"];
        [param setObject:@"50" forKey:@"queryType"];
    }
    
    self.resultAry = [NSArray array];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:param];
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
	return YES;
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{

    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    NSDictionary *resultDic = [resultJSON objectFromJSONString];
    if (resultDic && [resultDic count] > 0)
    {
        self.resultAry = [resultDic objectForKey:@"data"];
        if (resultAry && [resultAry count] > 0)
        {
            [listTable reloadData];
        }
        else
            [ZrsUtil showAlertMsg:@"没有取证材料数据" andDelegate:nil];
    }
    else
        [ZrsUtil showAlertMsg:@"后台系统异常" andDelegate:nil];
    
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
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_proofList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    }
    
    NSDictionary *tmpDic = [resultAry objectAtIndex:indexPath.row];
    NSString *typeStr = [tmpDic objectForKey:@"WJKZM"];
    NSString *timeStr = [tmpDic objectForKey:@"CJSJ"];
    cell.textLabel.text = [tmpDic objectForKey:@"SZWJNBMC"];
    UIImage *img = nil;
    if ([typeStr isEqualToString:@".jpg"])
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"拍摄于%@",timeStr];
        img = [UIImage imageNamed:@"picture.png"];
    }
    else if ([typeStr isEqualToString:@".mp3"])
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"录音于%@",timeStr];
        img = [UIImage imageNamed:@"sounds.png"];
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"取证于%@",timeStr];
        img = [UIImage imageNamed:@"otherMedia.png"];
    }
    
    cell.imageView.image = img;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDic = [resultAry objectAtIndex:indexPath.row];
    
    ShowQZCLVC *childVC = [[[ShowQZCLVC alloc] initWithNibName:@"ShowQZCLVC" bundle:nil] autorelease];
    childVC.infoDic = tmpDic;
    
    [self.navigationController pushViewController:childVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

@end
