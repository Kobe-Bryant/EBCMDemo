//
//  JFQKViewController.m
//  SZXQ
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "PWSFViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "JFQKDetailViewController.h"

@interface PWSFViewController ()

@end

@implementation PWSFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    curYearSelectTag = 0;
    // 开启 关闭查询按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil action:nil];
    UIBarButtonItem *chooseYearButton = [[UIBarButtonItem alloc] initWithTitle:@"选择年份"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(chooseYear:)];
    
    UIBarButtonItem *searchBut = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    
    toolBar.items = [NSArray arrayWithObjects:chooseYearButton,searchBut,flexItem, nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    [flexItem release];
    [chooseYearButton release];
    [toolBar release];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy"];
    NSDate *date = [NSDate date];
    NSString * dateStr = [formatter stringFromDate:date];
    self.title  = [NSString stringWithFormat:@"%@年排污收费情况",dateStr];
    self.yearStr = dateStr;
    [self requestData];
    yearsArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<20; i++) {
        int curYear = [_yearStr intValue]-i;
        NSString * year = [NSString stringWithFormat:@"%i",curYear];
        [yearsArr addObject:year];
    }
    [self showSearchBar:nil];
}

-(void)showSearchBar:(id)sender{
    
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender;
    if(!bHaveShow)
    {
        CGRect origFrame = _tableView.frame;
        aItem.title = @"开启查询";
        _qymcF.text = @"";
        _qymcLb.hidden = YES;
        _qymcF.hidden = YES;
        _searchBut.hidden = YES;
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:_tableView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _tableView.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-65, origFrame.size.width, origFrame.size.height+65);
        [UIView commitAnimations];
        
        [_qymcF resignFirstResponder];
    }
    else{
        aItem.title = @"关闭查询";
        CGRect origFrame = _tableView.frame;
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:_tableView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        _tableView.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+65, origFrame.size.width, origFrame.size.height-65);
        [UIView commitAnimations];
    }
    bHaveShow = !bHaveShow;

    //苏州爱建电瓷有限公司
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    _qymcF.hidden = NO;
    _qymcLb.hidden = NO;
    _searchBut.hidden = NO;
}


-(void)chooseYear:(id)sender{
    
    if (popover) {
        [popover dismissPopoverAnimated:YES];
    }
    
    PaiKouTableViewController *controller = [[PaiKouTableViewController alloc] initWithStyle:UITableViewStylePlain AndInfoArr:yearsArr AndCurSelect:curYearSelectTag];
    controller.delegage = self;
    controller.curWuRanType = 3;
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    [controller release];
    popover.contentSize = CGSizeMake(200, 300);
    popover.tint = FPPopoverLightGrayTint;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:locationView];
}

#pragma mark - PaiKouTableViewController的delegate处理

-(void)didSelectPaiKou:(NSDictionary *)PaiKouDic AndCurSelect:(int)curtag{
    
    curYearSelectTag = curtag;
    [popover dismissPopoverAnimated:YES];
    [popover autorelease];
    self.yearStr = [yearsArr objectAtIndex:curYearSelectTag];
    self.title  = [NSString stringWithFormat:@"%@年排污收费情况",_yearStr];
    [self requestData];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    locationView = [[UIView alloc] initWithFrame:CGRectMake(600, 4.0, 35.0, 32.0)];
    locationView.userInteractionEnabled = NO;
    locationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:locationView];
    [locationView release];

    [super viewWillAppear:animated];
}

#pragma mark SelectDateDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


#pragma mark RequestData
- (IBAction)requestData
{
    NSString * qymc = _qymcF.text;
    if (qymc==nil) {
        qymc = @"";
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"QUERY_PWSF_JFQKCX" forKey:@"service"];
    [params setObject:@"json" forKey:@"dataType"];
    [params setObject:_yearStr forKey:@"selectYear"];
    [params setObject:qymc forKey:@"qymc"];
    NSString *requestURL = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:requestURL
                                                andParentView:self.view
                                                     delegate:self] autorelease];
}

#pragma mark URLConnHelperDelegate
- (void)processWebData:(NSData *)webData
{
    NSString *resultString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    self.resultArray = [resultString objectFromJSONString];
    [resultString release];
    if (self.resultArray == nil || [self.resultArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        self.resultArray = [NSArray array];
    }
    [self.tableView reloadData];
}

- (void)processError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"请求数据失败,请检查网络连接并重试。"
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    NSDictionary *item = [self.resultArray objectAtIndex:indexPath.row];
    // 企业名称
    NSString *QYMC = [item objectForKey:@"a"];
    //废水废气噪声
    NSString *fs = [item objectForKey:@"c"];
    NSString *fq = [item objectForKey:@"d"];
    NSString *zs = [item objectForKey:@"e"];
    NSString *subvalue1 = [NSString stringWithFormat:@"废水费用：%@    废气费用：%@    噪声费用：%@" , fs,fq,zs];
    
    // 应收金额总计
    NSString *YSJEZJ = [NSString stringWithFormat:@"应收金额总计：%@",[item objectForKey:@"b"]];
    
    cell = [UITableViewCell makeSubCell:tableView withTitle:QYMC SubValue1:subvalue1 SubValue2:YSJEZJ SubValue3:@""];
    if (indexPath.row == _resultArray.count-1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultArray count];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"查询结果";
}

#pragma mark UITableViewDelegate
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
    if (indexPath.row==_resultArray.count-1) {
        return;
    }
    
    NSDictionary *JFQKDetail = [self.resultArray objectAtIndex:indexPath.row];
    JFQKDetailViewController *JFQKDetailVC = [[JFQKDetailViewController alloc]
                                              initWithNibName:@"JFQKDetailViewController" bundle:nil];
    JFQKDetailVC.JFQKDetail = JFQKDetail;
    JFQKDetailVC.curYearStr = _yearStr;
    
    [self.navigationController pushViewController:JFQKDetailVC animated:YES];
    [JFQKDetailVC release];

}

- (void)dealloc
{
    [popover release];
    [yearsArr release];
    [_yearStr release];
    [_tableView release];
    [_urlConnHelper release];
    [_resultArray release];
    [_qymcLb release];
    [_searchBut release];
    [_qymcF release];
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.urlConnHelper) {
        [self.urlConnHelper cancel];
        self.urlConnHelper.delegate = nil;
    }
    [locationView removeFromSuperview];
    [super viewWillDisappear:animated];
}
- (void)viewDidUnload {
    [self setQymcLb:nil];
    [self setSearchBut:nil];
    [self setQymcF:nil];
    [super viewDidUnload];
}
- (IBAction)searchClick:(id)sender {
    
    [self requestData];
}
@end
