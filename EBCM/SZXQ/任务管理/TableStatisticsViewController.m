//
//  TableStatisticsViewController.m
//  SZXQ
//
//  Created by ihumor on 12-12-29.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "TableStatisticsViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "NTChartView.h"
#import "ChartItem.h"
#import "HtmlTableGenerator.h"
#import "TFHpple.h"
#import "UITableViewCell+Custom.h"


@interface TableStatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NTChartView *chartView;
@property (nonatomic,retain) NSArray *valueArray;
@property (nonatomic,retain) NSString * service;
@property (nonatomic,assign) BOOL isGraph;
@property (nonatomic,assign) BOOL isDisplay;
@property (nonatomic,strong) NSMutableArray* resultArr;//html解析获取值
@property (nonatomic,assign) BOOL isTableView; //判断是否要用tableview
@end

@implementation TableStatisticsViewController
@synthesize aIndex,page,service,chartView,valueArray;
@synthesize resultArr;

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
   
    self.myWebView.scalesPageToFit = YES;
    int curIndex = 0;
    switch (page) {
        case 0:
            if (aIndex==0)curIndex = QJRWTJ;
            if (aIndex==1)curIndex = MBRW;
            self.isTableView = YES;
          break;
        case 1:
            if (aIndex==0)curIndex = LZRB;
            if (aIndex==1)curIndex = LZZB;
            if (aIndex==2)curIndex = LZYB;
            if (aIndex==3)curIndex = LZNB;
            break;
        case 2:
            if (aIndex==0)curIndex = JSXMSPTJ;
            if (aIndex==1)curIndex = JSXMHBTSTJ;
            self.isTableView = YES;
            break;
        case 3:
            if (aIndex==0){
                self.isGraph = YES;
                curIndex = PWSFTJ;
            }
            if (aIndex==1){
                self.isGraph = YES;
                curIndex = SFPWLTJ;
            }
            break;
        case 4:
            if (aIndex==0){
                self.isTableView = YES;
                curIndex = HJXFJCTJ;
            }
            if (aIndex==1){
                self.isGraph = YES;
                curIndex = HJXFJDTJ;
            }
            break;
        case 5:
            if (aIndex==0)curIndex = PWXKZTJ;
            self.isTableView = YES;
            break;
        case 6:
            if (aIndex==0)curIndex = QQFSYTJ;
            self.isTableView = YES;
            break;
        case 7:
            if (aIndex==0){
                curIndex = WFZYSPTJ;
                self.isGraph = YES;
            }
            if (aIndex==1){
                curIndex = DZFWCJTJ;
                self.isGraph = YES;
            }
            break;
        case 8:
            if (aIndex==0){
                curIndex = JCZHPYSTJ;
               self.isTableView = YES;
            }
            if (aIndex==1){
                curIndex = JCZXMWCTJ;
                self.isTableView = YES;
            }
            if (aIndex==2){
                curIndex = JCXZTJ;
                self.isGraph = YES;
            }
            break;
        case 9:
            if (aIndex==0){
                curIndex = YDZFTJ;
                self.isTableView = YES;
            }
            if (aIndex==1){
                curIndex = GRZFTJ;
                self.isGraph = YES;
            }
            if (aIndex==2){
                curIndex = AJDZFTJ;
                self.isGraph = YES;
            }
            break;
        default:
            break;
    }
    curTJType = curIndex;
    //根据不同模块 添加不同的查询条件
    if (curIndex==QJRWTJ) {
        //任务统计
    }
    else if(curIndex==MBRW){
        //目标任务
    }
    else if(curIndex==LZRB){
        //蓝藻日报
    }
    else if(curIndex==LZZB){
        //蓝藻周报
    }
    else if(curIndex==LZYB){
        //蓝藻月报
    }
    else if (curIndex==LZNB){
        //蓝藻年报
        locationView = [[UIView alloc] initWithFrame:CGRectMake(700, 4.0, 35.0, 35.0)];
        locationView.userInteractionEnabled = NO;
        locationView.backgroundColor = [UIColor clearColor];
        [self.navigationController.navigationBar addSubview:locationView];
        [locationView release];
        
        //导航栏按钮
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
        UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered  target:self action:@selector(chooseYear:)];
        
        toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
        [flexItem release];
        [item2 release];
        [toolBar release];
    }
    else if (curIndex==HJXFJCTJ){
        
        //环境信访监察统计
        NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy"];
        NSDate *date = [NSDate date];
        NSString * dateStr = [formatter stringFromDate:date];
        self.yearStr = dateStr;
        yearsArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i<20; i++) {
            int curYear = [_yearStr intValue]-i;
            NSString * year = [NSString stringWithFormat:@"%i",curYear];
            [yearsArr addObject:year];
        }
        locationView = [[UIView alloc] initWithFrame:CGRectMake(700, 4.0, 35.0, 35.0)];
        locationView.userInteractionEnabled = NO;
        locationView.backgroundColor = [UIColor clearColor];
        [self.navigationController.navigationBar addSubview:locationView];
        [locationView release];
        
        //导航栏按钮
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
        UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"选择年份" style:UIBarButtonItemStyleBordered  target:self action:@selector(chooseYear:)];
        
        toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
        [flexItem release];
        [item2 release];
        [toolBar release];

    }
    else if(curIndex==QQFSYTJ){
        //全区放射源统计
    }
    else{
        //导航栏按钮
        
        NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy"];
        NSDate *date = [NSDate date];
        NSString * dateStr = [formatter stringFromDate:date];
        self.yearStr = dateStr;
        yearsArr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i<20; i++) {
            int curYear = [_yearStr intValue]-i;
            NSString * year = [NSString stringWithFormat:@"%i",curYear];
            [yearsArr addObject:year];
        }
        locationView = [[UIView alloc] initWithFrame:CGRectMake(600, 4.0, 35.0, 35.0)];
        locationView.userInteractionEnabled = NO;
        locationView.backgroundColor = [UIColor clearColor];
        [self.navigationController.navigationBar addSubview:locationView];
        [locationView release];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,180, 44)];
        UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *item1 = [[UIBarButtonItem  alloc] initWithTitle:@"选择年度" style:UIBarButtonItemStyleBordered  target:self action:@selector(chooseYear:)];
        UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
        
        toolBar.items = [NSArray arrayWithObjects: item1,item2,flexItem,nil];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    }       bHaveShow = YES;
    [self showSearchBar:nil];

    _startF.tag = 1;
    _endF.tag = 2;
    PopupDateViewController *dateCtrl = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
    self.dateSelectCtrl = dateCtrl;
    _dateSelectCtrl.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_dateSelectCtrl];
    UIPopoverController *popCtrl1 = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.datePopover = popCtrl1;
    [dateCtrl release];
    [nav release];
    [popCtrl1 release];
    
    if (!self.isGraph&&!self.isTableView) {
        self.hisgramView.hidden = YES;
        self.myWebView.frame = CGRectMake(0, self.myWebView.frame.origin.y, 768, self.myWebView.frame.size.height+40);
    }
    
    //增加tableview
    self.myTableView = [[UITableView alloc]initWithFrame:self.myWebView.frame style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.rowHeight = 40;
    [self.view addSubview:self.myTableView];
    self.myTableView.hidden = YES;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestNetWorkData];
    
}

-(void)chooseYear:(id)sender{
    
    if (popover) {
        [popover dismissPopoverAnimated:YES];
    }
    
    PaiKouTableViewController *controller = [[PaiKouTableViewController alloc] initWithStyle:UITableViewStylePlain AndInfoArr:yearsArr AndCurSelect:curYearSelectTag];
    controller.delegage = self;
    if (curTJType==LZNB) {
        controller.curWuRanType = 4;
    }
    else{
        controller.curWuRanType = 3;
    }
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
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    if (curTJType==LZNB) {
        [params setObject:@"QUERY_LZTJ" forKey:@"service"];
        [params setObject:[[yearsArr objectAtIndex:curYearSelectTag] objectForKey:@"站点ID"] forKey:@"portId"];
        [params setObject:[[yearsArr objectAtIndex:curYearSelectTag] objectForKey:@"站点名称"] forKey:@"portName"];
    }
    else if(curTJType==HJXFJCTJ){
        self.yearStr = [yearsArr objectAtIndex:curYearSelectTag];
        [params setObject:@"QUERY_HJXFTJ" forKey:@"service"];
        [params setObject:_yearStr forKey:@"selectYear"];
    }
    else{
        
        NSString * yearStr = [yearsArr objectAtIndex:curYearSelectTag];
        NSString * startTime = [NSString stringWithFormat:@"%@-01-01",yearStr];
        NSString * endTime = [NSString stringWithFormat:@"%@-12-31",yearStr];
        _startF.text = startTime;
        _endF.text = endTime;
        [self requestNetWorkData];
        return;
    }
  
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
    
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
            _startF.text = dateString;
        else
            _endF.text = dateString;
    }
    
    [_datePopover dismissPopoverAnimated:YES];
}


- (void)showSearchBar:(id)sender {
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender;
    if(bHaveShow)
    {
        [_startF resignFirstResponder];
        [_endF resignFirstResponder];
        
        bHaveShow = NO;
        CGRect origFrame = _myWebView.frame;
        aItem.title = @"开启查询";
        _startlb.hidden = YES;
        _startF.hidden = YES;
        _endF.hidden = YES;
        _endlb.hidden = YES;
        _searchBut.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:_myWebView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _myWebView.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-50, origFrame.size.width, origFrame.size.height+50);
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShow = YES;
        CGRect origFrame = _myWebView.frame;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:_myWebView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        _myWebView.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+50, origFrame.size.width, origFrame.size.height-50);
        
        [UIView commitAnimations];
        
    }
}


#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark - Private methods
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    _startlb.hidden = NO;
    _startF.hidden = NO;
    _endF.hidden = NO;
    _endlb.hidden = NO;
    _searchBut.hidden = NO;
}

-(void)requestNetWorkData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    NSArray * serviceArr = [NSArray arrayWithObjects:@"QUERY_GKSRWTJ",@"",@"",@"",@"",@"QUERY_LZTJ",@"QUERY_JSXMTJ",@"QUERY_JSXMHBTZTJ",@"QUERY_PWSFTJ",@"QUERY_SFPWLTJ",@"QUERY_HJXFTJ",@"QUERY_HJXFJDTJ",@"QUERY_PWXKZTJ",@"QUERY_GFFSTJ",@"QUERY_WFZYSPTJ",@"QUERY_DZFWCJTJ",@"QUERY_JCZTJ",@"QUERY_JCZXMWCTJ",@"QUERY_JCXZTJ",@"QUERY_XCZFBL_RWTJ",@"QUERY_GRZFTJ",@"QUERY_XZQHZFTJ", nil];
    service = [serviceArr objectAtIndex:curTJType];
    if ([service isEqualToString:@""]) {
        return;
    }
    NSString * startTime = _startF.text;
    NSString * endTime = _endF.text;
    
    [params setObject:service forKey:@"service"];
    
    if (startTime!=nil||![startTime isEqualToString:@""]) {
        [params setObject:startTime forKey:@"startdate"];
    }
    
    if (endTime!=nil||![endTime isEqualToString:@""]) {
        [params setObject:endTime forKey:@"enddate"];
    }

    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    //提取title
    NSRange range = [resultJSON rangeOfString:@"<title>"];
    NSRange range1 = [resultJSON rangeOfString:@"</title>"];
    if (range.length>0) {
        NSRange range2 = {(range.length+range.location),range1.location-(range.length+range.location)};
        NSString * titleStr = [resultJSON substringWithRange:range2];
        self.title = titleStr;
    }
    
    if (!isGetPort)
    {
        if (self.myWebView.superview)
            [_myWebView removeFromSuperview];

        NSArray *comArray = [resultJSON componentsSeparatedByString:@"#####"];
        if (comArray && comArray.count >= 2) {
            NSDictionary *jsonDic = [[comArray objectAtIndex:0]objectFromJSONString];
            NSArray *jsonArray = [jsonDic objectForKey:@"data"];
            if (jsonArray && jsonArray.count) {
                if (self.isGraph)
                {
                  self.valueArray = [HtmlTableGenerator genContentWithParaMeters:jsonArray andServiceType:service];
                }
            }
            resultJSON = [comArray objectAtIndex:1];
        }
        
        _myWebView.dataDetectorTypes = UIDataDetectorTypeNone;
        [_myWebView loadHTMLString:resultJSON baseURL:[[NSBundle mainBundle] bundleURL]];
        _myWebView.scalesPageToFit = YES;
        [self addView:self.myWebView type:@"pageCurl" subType:kCATransitionFromRight];
        //用tableview显示数据
        if (self.isTableView)
        {
            self.myTableView.hidden = NO;
            _myWebView.hidden = YES;
            [self AnalyticalCont:resultJSON];
            self.valueArray = [self valuesData:1];
            [self.myTableView reloadData];
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.myTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
        self.isDisplay = YES;
        [self openHistogram];
        
        if (curTJType==LZNB&&yearsArr.count==0) {
            //获取排口
            isGetPort = YES;
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
            
            [params setObject:@"QUERY_WATER_STATION_LIST" forKey:@"service"];
            [params setObject:@"WATER" forKey:@"type"];
            NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
            self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
            
        }
        
    }
    else{
        yearsArr = [[NSMutableArray alloc] initWithArray:[resultJSON  objectFromJSONString]];
        isGetPort = NO;
    }

}

- (void)addView:(UIView *)view type:(NSString *)type subType:(NSString *)subType
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = type;
    transition.subtype = subType;
    [self.view addSubview:view];
    [[view layer] addAnimation:transition forKey:@"ADD"];
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
    isGetPort = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if(locationView){
        [locationView removeFromSuperview];
    }
    if (_urlConnHelper)
        [_urlConnHelper cancel];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    if (yearsArr) {
        [yearsArr release];
        [popover release];
        [_yearStr release];
    }
    [_myWebView release];
    [_startlb release];
    [_startF release];
    [_endlb release];
    [_endF release];
    [_searchBut release];
    [_hisgramView release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyWebView:nil];
    [self setStartlb:nil];
    [self setStartF:nil];
    [self setEndlb:nil];
    [self setEndF:nil];
    [self setSearchBut:nil];
    [self setHisgramView:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}
- (IBAction)searchButClick:(id)sender {
    
    [self requestNetWorkData];
}

- (IBAction)selectDate:(id)sender {
    
    if (_datePopover)
        [_datePopover dismissPopoverAnimated:YES];
    
    UITextField *fie = (UITextField *)sender;
    fie.text = @"";
    
    currentTag = fie.tag;
    [_datePopover presentPopoverFromRect:[fie bounds] inView:fie permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)hisgramBtnClick:(UIButton *)sender
{
    if (self.isDisplay == NO)
    {
        [self openHistogram];
        self.isDisplay = YES;
    }
    else
    {
        [self closeHistogram];
        self.isDisplay = NO;
    }
}
-(void)openHistogram
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.hisgramView.frame = CGRectMake(0, 510, 768, 450);
    self.myWebView.frame = CGRectMake(0, self.myWebView.frame.origin.y, 768, self.myWebView.frame.size.height-410);
    if (self.isTableView) {
        self.myTableView.frame = self.myWebView.frame;
    }
    [UIView commitAnimations];
    [self addChartView];
}
-(void)addChartView
{
    if(self.chartView)
        [self.chartView removeFromSuperview];

    self.chartView = [[NTChartView alloc] initWithFrame:CGRectMake(0, 40, 768, self.hisgramView.frame.size.height)];
	[self.hisgramView addSubview:self.chartView];
    
    NSMutableArray *itemArray = [NSMutableArray array];

    for (int i=0; i<[self.valueArray count]; i++)
    {
        NSDictionary *valueDic = [valueArray objectAtIndex:i];
        float value = [[valueDic objectForKey:@"value"] floatValue];
        NSString *name = [valueDic objectForKey:@"name"];
        UIColor *aColor = [[[ChartItem makeColorArray]objectAtIndex:i] retain];
        ChartItem *aItem  = [ChartItem itemWithValue:value Name:name Color:aColor.CGColor];
        [itemArray addObject:aItem];
    }
    
    [self.chartView addGroupArray:itemArray withGroupName:@"group"];
}

-(void)closeHistogram
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.hisgramView.frame = CGRectMake(0, 920, 768, 40);
    self.myWebView.frame = CGRectMake(0, self.myWebView.frame.origin.y, 768, self.myWebView.frame.size.height+410);
    self.myTableView.frame = self.myWebView.frame;
    [UIView commitAnimations];
}

//获取统计图value数组值
-(NSArray*)valuesData:(NSInteger)index
{
    NSMutableArray* paramAr = [[NSMutableArray alloc]init];
   
    NSArray* nameAr = [[NSArray alloc]initWithArray:[self.resultArr objectAtIndex:0]];
    NSArray* valueAr = [[NSArray alloc]initWithArray:[self.resultArr objectAtIndex:index]];
    for (int k=1; k<[[self.resultArr objectAtIndex:0] count]; k++)
    {
         NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[nameAr objectAtIndex:k] forKey:@"name"];
        [dic setObject:[valueAr objectAtIndex:k] forKey:@"value"];
        [paramAr addObject:dic];
    }
    return paramAr;
}

//html解析 获取对应值
#pragma cont 
-(NSMutableArray *)AnalyticalCont:(NSString *)htmlString{
    
    NSRange rang1=[htmlString rangeOfString:@"<table"];
    if (rang1.length<=0) {
        return nil;
    }
    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[htmlString substringFromIndex:rang1.location]];
    
    NSRange rang2=[imageStr2 rangeOfString:@"</table>"];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
    
//    NSLog(@" cont  imageStr3 %@",imageStr3);
    
    NSData *htmlData=[imageStr3 dataUsingEncoding:/*CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)*/NSUTF8StringEncoding];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    NSArray *arrCounts  = [xpathParser searchWithXPathQuery:@"//tr"];
//    NSLog(@" cont elements %@ ",elements);
    
    self.resultArr = [[NSMutableArray alloc]init];
    
    for (TFHppleElement *arrCount in arrCounts)
    {
        if ([arrCount content]!=nil)
        {
            NSMutableArray* ar = [NSMutableArray arrayWithCapacity:1];
            for (TFHppleElement* element in [arrCount children]) {
                NSLog(@" TFHppleElement *element %@",[element content]);
                [ar addObject:[element content]];
            }
            [self.resultArr addObject:ar];
        }
    }
//    NSLog(@"result array %@",self.resultArr);
    return self.resultArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultArr count]-1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 40)];
    NSArray* ar = [[NSArray alloc]init];
    ar = [self.resultArr objectAtIndex:0];
    int width = 740.0/[ar count];
    CGRect tRect = CGRectMake(14, 5, width, 40);
    
    for (int i =0; i < [ar count]; i++) {
        UILabel *label =[[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor blackColor]];
        label.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        label.textAlignment = UITextAlignmentCenter;
        tRect.origin.x += width;
        [label setText:[ar  objectAtIndex:i]];
        [cellView addSubview:label];
        [label release];
    }
    cellView.backgroundColor = CELL_HEADER_COLOR;
    return cellView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    cell = [UITableViewCell makeSubCell:tableView withValue1:[self.resultArr objectAtIndex:indexPath.row+1] height:40];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   self.valueArray = [self valuesData:indexPath.row+1];
    [self addChartView];
}







@end











