//
//  XZCFDetailVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XZCFDetailVC.h"
#import "ServiceUrlString.h"
#import "HtmlTableGenerator.h"
#import "ServiceType.h"
#import "JSONKit.h"
#import "AttachmentVC.h"

@implementation XZCFDetailVC
@synthesize webservice,wrybh;
@synthesize urlStr,xh,fjArray;


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
    [param setObject:@"QUERY_WRY_XZCF_DETAIL" forKey:@"service"];
    [param setObject:wrybh forKey:@"wrybh"];
    [param setObject:xh forKey:@"xh"];
    
    self.urlStr = [ServiceUrlString generateUrlByParameters:param];
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
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    NSDictionary *receiveDic = [resultJSON objectFromJSONString];
    NSDictionary *resultDic = [receiveDic objectForKey:@"data"];
    if([resultDic objectForKey:@"columnNames"] !=nil){
        NSArray *aryTmp = [resultDic objectForKey:@"rows"];
        if (aryTmp && [aryTmp count] >0 ) {
            resultDic = [aryTmp objectAtIndex:0];
        }else {
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
    }
    
    NSDictionary *fjDic  = [receiveDic objectForKey:@"fj"];
    self.fjArray = [fjDic objectForKey:@"rows"];
    if (fjArray && [fjArray count] > 0)
        [attachTV reloadData];
    else
    {
        self.fjArray = [NSArray array];
        [attachTV reloadData];
    }
    
    
    NSUInteger  serviceType = TYPE_QUERY_WRY_XZCF_DETAIL;
    NSString *htmlStr = [HtmlTableGenerator genContentWithTitle:@"处罚决定书详情" andParaMeters:resultDic andType:serviceType];
    myWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [myWebView loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
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

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([fjArray count] > 0)
        return [fjArray count];
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"attachmentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    
    if ([fjArray count] > 0)
    {
        NSDictionary *tmpDic = [fjArray objectAtIndex:indexPath.row];
        NSString *name = [NSString stringWithFormat:@"%@%@",[tmpDic objectForKey:@"FJMC"],[tmpDic objectForKey:@"HZM"]];
        cell.textLabel.text = name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.textLabel.text = @"没有相关附件";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"没有相关附件"])
        return;
    NSDictionary *tmpDic = [fjArray objectAtIndex:indexPath.row];
    NSString *path = [tmpDic objectForKey:@"LJ"];
    NSString *hzm = [tmpDic objectForKey:@"HZM"];
    NSString *name = [tmpDic objectForKey:@"FJMC"];
    
    AttachmentVC *childVC = [[[AttachmentVC alloc] initWithNibName:@"AttachmentVC" bundle:nil] autorelease];
    childVC.WJMC = name;
    childVC.HZ = hzm;
    childVC.WJLJ = path;
    childVC.gllx = @"XZCF_SMWJ";
    
    [self.navigationController pushViewController:childVC animated:YES];
}

@end
