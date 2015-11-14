//
//  DoneTaskListVC.m
//  HNMobileLaw
//
//  Created by 王 哲义 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DoneTaskListVC.h"
#import "JSONKit.h"
#import "DoneTaskDetailsVC.h"
#import "UITableViewCell+Custom.h"
#import "ServiceUrlString.h"

@implementation DoneTaskListVC
@synthesize listTable,businessField;
@synthesize startDateField,endDateField,searchBtn;
@synthesize webservice,resultAry;
@synthesize businessLbl,startDateLbl,endDateLbl;
@synthesize currentTag,bHaveShow,urlString;
@synthesize datePopover,dateSelectCtrl;

#pragma mark - Private methods

- (void)getWebData
{
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];
}

- (IBAction)searchBtnPressed:(id)sender
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:10];
    [param setObject:@"QUERY_XCZF_INFO" forKey:@"service"];
    [param setObject:@"true" forKey:@"isSelf"];
    
    if ([businessField.text length] > 0)
        [param setObject:businessField.text forKey:@"wrymc"];
    
    if ([startDateField.text length] > 0)
        [param setObject:startDateField.text forKey:@"startDate"];
    
    if ([endDateField.text length] > 0)
        [param setObject:endDateField.text forKey:@"endDate"];
     
    
    self.urlString = [ServiceUrlString generateUrlByParameters:param];
    
    [self getWebData];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    businessLbl.hidden = NO;
    businessField.hidden = NO;
    startDateLbl.hidden = NO;
    startDateField.hidden = NO;
    endDateLbl.hidden = NO;
    endDateField.hidden = NO;
    searchBtn.hidden = NO;
}

- (void)showSearchBar:(id)sender {
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender; 
    if(bHaveShow)
    {
        [businessField resignFirstResponder];
        [startDateField resignFirstResponder];
        [endDateField resignFirstResponder];
 
        bHaveShow = NO;
        CGRect origFrame = listTable.frame;
        aItem.title = @"开启查询";
        businessLbl.hidden = YES;
        businessField.hidden = YES;
        startDateLbl.hidden = YES;
        startDateField.hidden = YES;
        endDateLbl.hidden = YES;
        endDateField.hidden = YES;
        searchBtn.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:listTable];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-105, origFrame.size.width, origFrame.size.height+140);        
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShow = YES;
        CGRect origFrame = listTable.frame;
        
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:listTable];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+105, origFrame.size.width, origFrame.size.height-140);
        
        [UIView commitAnimations];
        
    }
}

- (IBAction)selectDate:(id)sender
{
    if (datePopover)
        [datePopover dismissPopoverAnimated:YES];
    UITextField *fie = (UITextField *)sender;
    fie.text = @"";
    
    UIControl *btn = (UIControl *)sender;
    currentTag = btn.tag;
    [datePopover presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

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
    self.title = @"已办任务列表";
    
    //选择时间
    [startDateField addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    [endDateField addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    
    PopupDateViewController *dateCtrl = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
    self.dateSelectCtrl = dateCtrl;
    dateSelectCtrl.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateSelectCtrl];
    UIPopoverController *popCtrl1 = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.datePopover = popCtrl1;
    [dateCtrl release];
    [nav release];
    [popCtrl1 release];
    
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    
    bHaveShow = YES;
    [self showSearchBar:item2];
    
    toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    [toolBar release];
    [item2 release];
    [flexItem release];
    
    //获取默认数据
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:10];
    [param setObject:@"QUERY_XCZF_INFO" forKey:@"service"];
    [param setObject:@"true" forKey:@"isSelf"];
    self.urlString = [ServiceUrlString generateUrlByParameters:param];
    [self getWebData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (datePopover)
        [datePopover dismissPopoverAnimated:YES];
    if (webservice)
        [webservice cancel];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark - PopoverDate delegate

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date;
{
    if (bSaved) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        if ([dateString isEqualToString:@"2013-12-30"]) {
            dateString = @"2012-12-30";
        }
        else if([dateString isEqualToString:@"2013-12-31"]) {
            dateString = @"2012-12-31";
        }
        
        if (currentTag == 1)
            startDateField.text = dateString;
        else
            endDateField.text = dateString;
    }
    
    [datePopover dismissPopoverAnimated:YES];
}

#pragma mark - URLConnHelper delegate

-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *tmpDic = [resultJSON objectFromJSONString];
    
    self.resultAry = [tmpDic objectForKey:@"data"];
    
    if (resultAry == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的已办任务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    [listTable reloadData];
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

#pragma mark - Table View Data Source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	return 78;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if (resultAry)
        row = [resultAry count];
    return row;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"查询结果";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *tmpDic = [resultAry objectAtIndex:row];
    
    NSString *aTitle = [NSString stringWithFormat:@"【%@】",[tmpDic objectForKey:@"WRYMC"]];
    NSString *aCase = [NSString stringWithFormat:@"%@",[tmpDic objectForKey:@"RWBLR"]];
    NSString *typeStr = [NSString stringWithFormat:@"办结时间:%@",[tmpDic objectForKey:@"BJSJ"]];
    NSString *status = @"未办结";
    if ([typeStr length] > 0)
        status = @"已办结";
    
    NSString *dateLimit = [NSString stringWithFormat:@"开始时间:%@",[tmpDic objectForKey:@"KSSJ"]];
    
    UITableViewCell *cell = [UITableViewCell makeSubCell:tableView withTitle:aTitle andSubvalue1:aCase andSubvalue2:typeStr andSubvalue3:dateLimit andSubvalue4:status];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary *tmpDic = [resultAry objectAtIndex:row];
    
    DoneTaskDetailsVC *childView = [[[DoneTaskDetailsVC alloc] initWithNibName:@"DoneTaskDetailsVC" bundle:nil] autorelease];
    childView.xczfbh = [tmpDic objectForKey:@"XCZFBH"];
    
    [self.navigationController pushViewController:childView animated:YES];
}


@end
