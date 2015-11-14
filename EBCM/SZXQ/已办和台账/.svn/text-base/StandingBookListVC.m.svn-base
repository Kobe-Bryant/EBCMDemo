//
//  StandingBookListVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StandingBookListVC.h"
#import "JSONKit.h"
#import "DoneTaskDetailsVC.h"
#import "UITableViewCell+Custom.h"
#import "ServiceUrlString.h"

@implementation StandingBookListVC
@synthesize listTable,businessField;
@synthesize startDateField,endDateField,searchBtn;
@synthesize webservice,resultAry;
@synthesize businessLbl,startDateLbl,endDateLbl;
@synthesize currentTag,bHaveShew,urlString;
@synthesize datePopover,dateSelectCtrl;
@synthesize wordsPopover,wordSelectCtrl,bAlone,rwbhStr;
@synthesize wrybh,wrymc,levelCodeAry,qualityValue;
@synthesize jgjbValue,ssdsValue,mainArray;

#pragma mark - Private methods

- (void)getWebData
{
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];
}

- (IBAction)searchBtnPressed:(id)sender
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:10];
    [param setObject:@"QUERY_XCZF_INFO" forKey:@"service"];
    if ([businessField.text length] > 0)
        [param setObject:[businessField.text copy] forKey:@"wrymc"];
    
    if ([startDateField.text length] > 0)
        [param setObject:[startDateField.text copy] forKey:@"startDate"];
    
    if ([endDateField.text length] > 0)
        [param setObject:[endDateField.text copy] forKey:@"endDate"];
    self.urlString = [ServiceUrlString generateUrlByParameters:param ignoreClientType:YES];
    
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
    if(bHaveShew)
    {
        [businessField resignFirstResponder];
        
        bHaveShew = NO;
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
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-188/2, origFrame.size.width, origFrame.size.height+188/2);
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShew = YES;
        CGRect origFrame = listTable.frame;
        
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:listTable];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+188/2, origFrame.size.width, origFrame.size.height-188/2);
        
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

- (IBAction)selectWord:(id)sender
{
    if (datePopover)
        [datePopover dismissPopoverAnimated:YES];
    if (wordsPopover)
        [wordsPopover dismissPopoverAnimated:YES];
    
    UITextField *fie = (UITextField *)sender;
    fie.text = @"";
    
    UIControl *btn = (UIControl *)sender;
    currentTag = btn.tag;
    
    switch (currentTag) {
        case 3:
            self.jgjbValue = @"";
            wordSelectCtrl.wordsAry = [NSArray arrayWithObjects:@"国控",@"省控",@"市控",@"非控", nil];
            break;
        case 4:
            self.ssdsValue = @"";
            NSMutableArray *cityNameAry = [NSMutableArray arrayWithCapacity:20];
            
            for (NSDictionary *cityDic in mainArray)
            {
                NSString *cityName = [cityDic objectForKey:@"name"];
                [cityNameAry addObject:cityName];
            }
            
            wordSelectCtrl.wordsAry = cityNameAry;
            break;
        case 5:
            self.qualityValue = @"";
            wordSelectCtrl.wordsAry = [NSArray arrayWithObjects:@"上级交办",@"领导批示",@"群众投诉",@"媒体报道",@"日常检查",@"专项检查",@"其它", nil];
            break;
            
        default:
            break;
    }
    
    [wordSelectCtrl.tableView reloadData];
    
    [wordsPopover presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        bAlone = YES;
        self.qualityValue = @"";
        self.ssdsValue = @"";
        self.levelCodeAry = [NSArray arrayWithObjects:@"1",@"2",@"3",@"9", nil];
        self.jgjbValue = @"";
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
    
    self.title = @"现场执法查询";
    
    //读取行政区划代码文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xzqh" ofType:@"plist"];
    NSDictionary *tmpDic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.mainArray = [tmpDic objectForKey:@"XZQHArray"];
    
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
    
    //选择短语
    CommenWordsViewController *wordCtrl = [[CommenWordsViewController alloc] initWithStyle:UITableViewStylePlain];
    [wordCtrl setContentSizeForViewInPopover:CGSizeMake(320, 400)];
    self.wordSelectCtrl = wordCtrl;
    wordSelectCtrl.delegate = self;
    UIPopoverController *popCtrl2 = [[UIPopoverController alloc] initWithContentViewController:wordSelectCtrl];
    self.wordsPopover = popCtrl2;
    [wordCtrl release];
    [popCtrl2 release];
    
        
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    
    bHaveShew = YES;
    [self showSearchBar:item2];
    
    toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:10];
    [param setObject:@"QUERY_XCZF_INFO" forKey:@"service"];
    if(wrybh && [wrybh length] > 0){
        self.navigationItem.rightBarButtonItem = nil;
        [param setObject:wrybh forKey:@"wrybh"];
    }
    
    if (bAlone)
    {
        
        //获取默认数据
        self.urlString = [ServiceUrlString generateUrlByParameters:param];
        [self getWebData];
    }
    else
    {
        
        
        
        [param setObject:@"true" forKey:@"fromZhrw"];
        [param setObject:rwbhStr forKey:@"zhrwbh"];
        self.urlString = [ServiceUrlString generateUrlByParameters:param];
    }
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
    if (wordsPopover)
        [wordsPopover dismissPopoverAnimated:YES];
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
    
    NSMutableString * receiveStr = [[NSMutableString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *tmpDic = [receiveStr objectFromJSONString];
    
    self.resultAry = [tmpDic objectForKey:@"data"];
    
    if (resultAry == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的已办任务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        self.resultAry = [NSArray array];
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
	return 72;
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
    
    NSString *aTitle = [NSString stringWithFormat:@"%@",[tmpDic objectForKey:@"DWMC"]];
    NSString *aCase = [NSString stringWithFormat:@"%@",[tmpDic objectForKey:@"ZFRY"]];
    NSString *typeStr = [NSString stringWithFormat:@"办结时间:%@",[tmpDic objectForKey:@"DCSJ"]];
    NSString *status = @"未办结";
    if ([typeStr length] > 0)
        status = @"已办结";
    NSString *kssj =[tmpDic objectForKey:@"KSSJ"];
    NSString *dateLimit = @"";
    if([kssj length] > 10)
        dateLimit = [NSString stringWithFormat:@"开始时间:%@",[kssj substringToIndex:10]];
    
    UITableViewCell *cell = [UITableViewCell makeSubCell:tableView
                                               withTitle:aTitle
                                            andSubvalue1:aCase
                                            andSubvalue2:typeStr
                                            andSubvalue3:dateLimit
                                            andSubvalue4:status];
    
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
    childView.daweiMC = [tmpDic objectForKey:@"DWMC"];
    [self.navigationController pushViewController:childView animated:YES];
}

-(void)dealloc{
    
    [listTable release];
    [businessLbl release];
    [startDateLbl release];
    [endDateLbl release];
    [businessField release];
    [startDateField release];
    [endDateField release];
    [searchBtn release];
    [resultAry release];
    [urlString release];
    [datePopover release];
    [dateSelectCtrl release];
    [wordsPopover release];
    [wordSelectCtrl release];
    [levelCodeAry release];
    [jgjbValue release];
    [ssdsValue release];
    [mainArray release];
    [qualityValue release];
    [rwbhStr release];
    [wrybh release];
    [wrymc release];
    [super dealloc];
}

@end
