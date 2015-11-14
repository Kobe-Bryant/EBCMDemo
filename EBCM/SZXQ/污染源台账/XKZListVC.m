//
//  XKZListVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XKZListVC.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "ZrsUtil.h"
#import "UITableViewCell+Custom.h"
#import "XKZDetailVC.h"

@implementation XKZListVC
@synthesize webservice,wrybh,wrymc,urlStr;
@synthesize resultAry;

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
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    [param setObject:@"QUERY_WRY_PWXKZ" forKey:@"service"];
    [param setObject:wrybh forKey:@"wrybh"];
    
    self.urlStr = [ServiceUrlString generateUrlByParameters:param];
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
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
    
    NSDictionary *receiveDic = [resultJSON objectFromJSONString];
    
    if ([receiveDic objectForKey:@"columnNames"] != nil)
    {
        self.resultAry = [receiveDic objectForKey:@"rows"];
        if (resultAry && [resultAry count] >0 ) 
        {
            [self.tableView reloadData];
        } else {
            [ZrsUtil showAlertMsg:@"请求数据失败,请检查网络连接并重试。" andDelegate:nil];
            return;
        }
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

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  82;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSDictionary *dic = [resultAry objectAtIndex:row];
    
    NSMutableString *pwlxStr = [NSMutableString stringWithFormat:@"排污类型: "];
    NSString *fq = [dic objectForKey:@"PWLX_FQ"];
    NSString *fs = [dic objectForKey:@"PWLX_FS"];
    NSString *zs = [dic objectForKey:@"PWLX_ZS"];
    NSString *gf = [dic objectForKey:@"PWLX_GF"];
    if ([fq isKindOfClass:[NSString class]] && [fq isEqualToString:@"on"])
        [pwlxStr appendString:@"废气 "];
    if ([fs isKindOfClass:[NSString class]] && [fs isEqualToString:@"on"])
        [pwlxStr appendString:@"废水 "];
    if ([gf isKindOfClass:[NSString class]] && [gf isEqualToString:@"on"])
        [pwlxStr appendString:@"固废 "];
    if ([zs isKindOfClass:[NSString class]] && [zs isEqualToString:@"on"])
        [pwlxStr appendString:@"噪声 "];
    NSRange range;
    range.location = [pwlxStr length]-1;
    range.length = 1;
    [pwlxStr deleteCharactersInRange:range];
    
    NSString *bhStr = [dic objectForKey:@"PWXKZBH"];
    
    NSString *fzdwStr = [dic objectForKey:@"FZDW"];
    fzdwStr = [NSString stringWithFormat:@"发证单位:%@",fzdwStr];
    
    NSString *fzsjStr = [dic objectForKey:@"FZSJ"];
    fzsjStr = [NSString stringWithFormat:@"发证日期:%@",fzsjStr];
    
    NSString *njyfStr = [dic objectForKey:@"NJYF"];
    njyfStr = [NSString stringWithFormat:@"年检月份:%@",njyfStr];
    
    UITableViewCell *cell = [UITableViewCell makeSubCell:tableView withTitle:bhStr andSubvalue1:fzdwStr andSubvalue2:pwlxStr andSubvalue3:fzsjStr andSubvalue4:njyfStr];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDic = [resultAry objectAtIndex:indexPath.row];
    
    XKZDetailVC *childVC = [[[XKZDetailVC alloc] initWithNibName:@"XKZDetailVC" bundle:nil] autorelease];
    childVC.wrybh = self.wrybh;
    childVC.xh = [tmpDic objectForKey:@"XH"];
    
    [self.navigationController pushViewController:childVC animated:YES];
}
@end
