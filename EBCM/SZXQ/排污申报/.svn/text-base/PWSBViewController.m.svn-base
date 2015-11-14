//
//  PWSBViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PWSBViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "PWSBDetailViewController.h"
#import "UITableViewCell+Custom.h"
@interface PWSBViewController ()

@end

@implementation PWSBViewController
@synthesize resTableView,wrymcField,hbjgjbSegCtrl,sfzxSegCtrl,urlConnHelper,returnAry;
@synthesize wrymcLabel,sfzxLabel,jgjbLabel,dwdzLabel,btnSearch,bHaveShow,wrydzField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    wrymcLabel.hidden = NO;
    sfzxLabel.hidden = NO;
    jgjbLabel.hidden = NO;
    dwdzLabel.hidden = NO;
    wrymcField.hidden = NO;
    hbjgjbSegCtrl.hidden = NO;
    sfzxSegCtrl.hidden = NO;
    btnSearch.hidden = NO;
    wrydzField.hidden = NO;

}

- (void)showSearchBar:(id)sender {
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender; 
    if(bHaveShow)
    {
        [wrymcField resignFirstResponder];
        [wrydzField resignFirstResponder];
        
        bHaveShow = NO;
        CGRect origFrame = resTableView.frame;
        aItem.title = @"开启查询";
        wrymcLabel.hidden = YES;
        sfzxLabel.hidden = YES;
        jgjbLabel.hidden = YES;
        dwdzLabel.hidden = YES;
        wrymcField.hidden = YES;
        hbjgjbSegCtrl.hidden = YES;
        sfzxSegCtrl.hidden = YES;
        btnSearch.hidden = YES;
        wrydzField.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:resTableView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        resTableView.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-105, origFrame.size.width, origFrame.size.height+105);        
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShow = YES;
        CGRect origFrame = resTableView.frame;
        
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:resTableView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        resTableView.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+105, origFrame.size.width, origFrame.size.height-105);
        
        [UIView commitAnimations];
        
    }
}

-(void)requestData{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_PWSB_LIST" forKey:@"service"];
    if([wrymcField.text length] > 0)
        [params setObject:wrymcField.text forKey:@"q_WRYMC"];
    
    if([wrydzField.text length] > 0)
        [params setObject:wrydzField.text forKey:@"q_DWDZ"];
    
    //"1">国控 "2">省控 "3">市控 "4">非控
    if(hbjgjbSegCtrl.selectedSegmentIndex > 0)
        [params setObject:[NSString stringWithFormat:@"%d",hbjgjbSegCtrl.selectedSegmentIndex] forKey:@"q_HBJGJB"];
    
    //"0" 否 “1”是
    if(sfzxSegCtrl.selectedSegmentIndex > 0)
        [params setObject:[NSString stringWithFormat:@"%d",sfzxSegCtrl.selectedSegmentIndex] forKey:@"q_SFZX"];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

-(IBAction)btnSearch:(id)sender{
    [self requestData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"排污申报";
    
    UIBarButtonItem *item = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    self.navigationItem.rightBarButtonItem = item;
    bHaveShow = YES;
    [self showSearchBar:item];
    [self requestData];
    [item release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:(id)UIInterfaceOrientationPortrait];
    }
    
    [resTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [resultJSON objectFromJSONString];
    [resultJSON release];
    if(dic)
        self.returnAry = [dic objectForKey:@"result"];
    if (dic ==nil || returnAry == nil||[returnAry count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        self.returnAry = [NSArray array];
    }
    
    [resTableView reloadData];
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper){
        [urlConnHelper cancel];
        urlConnHelper.delegate = nil;
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.wrymcField = nil;
    self.hbjgjbSegCtrl = nil;
    self.sfzxSegCtrl = nil;
}

-(void)dealloc{
    [wrymcField release];
    [hbjgjbSegCtrl release];
    [sfzxSegCtrl release];
    [returnAry release];
    [urlConnHelper release];
    [resTableView release];
    [super dealloc];
}

#pragma mark - tableview dataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"查询结果";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.returnAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSUInteger row = [indexPath row];
    NSDictionary *dic = [returnAry objectAtIndex:row];
    
    NSString *dz = [NSString stringWithFormat:@"地址:%@",[dic objectForKey:@"DWDZ"]];
    NSString *hblxr = [NSString stringWithFormat:@"环保联系人:%@",[dic objectForKey:@"HBLXR"]];
    NSString *lxdh = [NSString stringWithFormat:@"联系人电话:%@",[dic objectForKey:@"HBRLXDH"]];
    NSString *szqx = [NSString stringWithFormat:@"所在区县:%@",[dic objectForKey:@"XZQHMC"]];
    
    UITableViewCell *cell = [UITableViewCell makeSubCell:tableView withTitle:[dic objectForKey:@"WRYMC"] andSubvalue1:dz andSubvalue2:hblxr andSubvalue3:lxdh andSubvalue4:szqx];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PWSBDetailViewController *detailController= [[PWSBDetailViewController alloc] initWithNibName:@"PWSBDetailViewController" bundle:nil];
    NSUInteger row = indexPath.row;
    NSDictionary *dicBH = [returnAry objectAtIndex:row];
    detailController.factID = [NSString stringWithFormat:@"%@",[dicBH objectForKey:@"WRYBH"]];
    detailController.wrymc = [dicBH objectForKey:@"WRYMC"];
    detailController.isFromWry = NO;
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];
}


@end
