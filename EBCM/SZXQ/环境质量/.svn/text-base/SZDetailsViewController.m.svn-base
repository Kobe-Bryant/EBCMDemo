//
//  SZDetailsViewController.m
//  SZXQ
//
//  Created by zhang on 12-11-28.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "SZDetailsViewController.h"

#import "NSURLConnHelper.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import <QuartzCore/QuartzCore.h>
#import "xfMoreDetailViewController.h"

@interface SZDetailsViewController ()
@property (nonatomic,strong) UITableView *dataTableView;
@property (nonatomic,strong) UIWebView *resultWebView;
@property (nonatomic,strong) S7GraphView *graphView;

@property (nonatomic, strong) UIPopoverController *popController;
@property(nonatomic,strong)NSURLConnHelper  *webHelper;
@property(nonatomic,strong)NSArray *aryYinziNames;
@property (nonatomic,strong) NSMutableString *html;
@property(nonatomic,copy) NSString *curYinziName;
@property(nonatomic,strong) NSArray *aryDataValues;
@property(nonatomic,strong) NSString *showDate;
@end

@implementation SZDetailsViewController
@synthesize dataTableView,resultWebView,graphView,popController;
@synthesize webHelper,aryYinziNames,html,curYinziName,aryDataValues;
@synthesize pointCode,pointName,showDate,curType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [curType release];
    [dataTableView release];
    [resultWebView release];
    [graphView release];
    [popController release];
    [aryYinziNames release];
    [html release];
    
    [super dealloc];
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

-(void)refreshWebView{
    
    NSString *width = @"452px";
    NSString *unit = @"";
    if(html == nil)
        self.html = [NSMutableString stringWithCapacity:300];
    [html setString:@""];
    [html appendFormat:@"<html><body topmargin=0 leftmargin=0><table width=\"%@\" bgcolor=\"#FFCC32\" border=1 bordercolor=\"#893f7e\" frame=below rules=none><tr><th><font color=\"Black\">%@监测详细信息</font></th></tr><table><table width=\"%@\" bgcolor=\"#893f7e\" border=0 cellpadding=\"1\"><tr bgcolor=\"#e6e7d5\" ><th>监测时间</th><th>监测数据</th></tr>",width,curYinziName,width];
    
    BOOL boolColor = true;
       
    for (int i = [aryDataValues count]-1; i >=0 ; i--) {
        NSDictionary *dicValue = [aryDataValues objectAtIndex:i];
        NSString *time = [NSString stringWithFormat:@"%@",[dicValue objectForKey:@"X"]];
        NSString * value = @"--";
        if ([dicValue objectForKey:curYinziName]!=nil) {
            float val = [[dicValue objectForKey:curYinziName] floatValue];
            NSString * valStr = nil;
            if ([curYinziName isEqualToString:@"叶绿素a"]) {
                valStr = [NSString stringWithFormat:@"%0.5f",val];
            }
            else{
                valStr = [NSString stringWithFormat:@"%0.2f",val];
            }
            value = [NSString stringWithFormat:@"%@ %@",valStr,unit];
        }
        
        [self.html appendFormat:@"<tr bgcolor=\"%@\">",boolColor ? @"#cfeeff" : @"#ffffff"];
        boolColor = !boolColor;
        [self.html appendFormat:@"<td align=center>%@</td><td align=center>%@</td>",time ,value];
        [self.html appendString:@"</tr>"];
        
    }
    
    [self.html appendString:@"</table></body></html>"];
    
    //添加webview
    [self.resultWebView loadHTMLString:html baseURL:nil];
    [self addView:self.resultWebView type:@"pageCurl" subType:kCATransitionFromRight];
    
    //添加统计图
    graphView.info = unit;
    [self.graphView reloadData];
    [self addView:self.graphView type:@"rippleEffect" subType:kCATransitionFromTop];

}


//后台传来的数据在年月日字符串前多了一些回车之类的字符串 此处除掉
-(NSString *)fitDateStr:(NSString *)str{
    NSString * fitStr = nil;
    NSArray * dateArr = [str componentsSeparatedByString:@"-"];
    if (dateArr.count>=3) {
        NSString * YearStr = [dateArr objectAtIndex:0];
        NSRange range = [YearStr rangeOfString:YearStr];
        if (range.length>4) {
            NSRange range1 = {range.length-4,4};
            YearStr = [YearStr substringWithRange:range1];
        }
        NSString * dayStr = [dateArr objectAtIndex:2];
        NSRange dayRange = [dayStr rangeOfString:dayStr];
        if (dayRange.length>2) {
            NSRange dayRange1 = {0,2};
            dayStr = [dayStr substringWithRange:dayRange1];
        }
        fitStr = [NSString stringWithFormat:@"%@-%@-%@",YearStr,[dateArr objectAtIndex:1],dayStr];
    }
    return fitStr;
}

-(void)processWebData:(NSData*)webData{
    
    
    
    NSString *receivedStr =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    if (isGetDate) {
        self.showDate = [self fitDateStr:receivedStr];
        isGetDate = NO;
        [self requestDetailDatas];
        return;
    }
    NSDictionary *receiveDic = [receivedStr objectFromJSONString];
    NSDictionary * keyDic = [receiveDic objectForKey:@"y"];
    NSArray * KeyArr = [keyDic allKeys];
    NSMutableArray * sortArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString * keyName in KeyArr) {
        NSDictionary * infDic = [keyDic objectForKey:keyName];
        NSString * displayKeyName = [infDic objectForKey:@"AliasName"];
        NSNumber * orderNum = [NSNumber numberWithInt:[[infDic objectForKey:@"order"] intValue]];
        NSMutableDictionary * lastDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [lastDic setValue:keyName forKey:@"id"];
        [lastDic setValue:displayKeyName forKey:@"name"];
        [lastDic setValue:orderNum forKey:@"order"];
        [sortArr addObject:lastDic];
    }
    NSSortDescriptor* sortByA = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:NO];
    [sortArr sortUsingDescriptors:[NSArray arrayWithObject:sortByA]];
    self.aryYinziNames = sortArr;
    NSArray * receivedAry = [receiveDic objectForKey:@"data"];
    if (receivedAry.count==0) {
        
        NSString * msg = [NSString stringWithFormat:@"未找到%@的实时监测数据!",showDate];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    if (receivedAry && [receivedAry count] > 0)
    {
        NSMutableArray * arr = [NSMutableArray arrayWithArray:receivedAry];
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"X" ascending:YES]];
        [arr sortUsingDescriptors:sortDescriptors];
        
        self.aryDataValues = arr;
        
        if (self.graphView.superview)
            [graphView removeFromSuperview];
        
        if (self.resultWebView.superview)
            [resultWebView removeFromSuperview];
        [self addView:self.dataTableView type:kCATransitionPush subType:kCATransitionFromLeft];
        self.curYinziName = [[aryYinziNames objectAtIndex:0] objectForKey:@"id"];
        
        if ([curYinziName isEqualToString:@"pH"]) {
            graphView.special = YES;
        }
        else{
            graphView.special = NO;
        }
        
        [self.dataTableView reloadData];
        [self refreshWebView];
        [self.graphView reloadData];
        [self.dataTableView reloadData];
        
    }

    
}

-(void)processError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"请求数据失败."
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    isGetDate = NO;
}

-(void)requestDetailDatas{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

    if (isGetDate) {
        [params setObject:@"QUERY_WATER_STATION_DATE" forKey:@"service"];
        [params setObject:@"1" forKey:@"getLatestDate"];
    }
    else{
        
        [params setObject:@"QUERY_WATER_STATION_CHARTDETAIL" forKey:@"service"];

    }
    [params setObject:pointName forKey:@"portName"];
    [params setObject:pointCode forKey:@"portId"];
    [params setObject:curType forKey:@"type"];
   
    NSArray *tmpAry = [showDate componentsSeparatedByString:@"-"];
    if([tmpAry count] >=3){
        [params setObject:[tmpAry objectAtIndex:0] forKey:@"year"];
        [params setObject:[tmpAry objectAtIndex:1] forKey:@"month"];
        [params setObject:[tmpAry objectAtIndex:2] forKey:@"day"];
    }

    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}


-(void)chooseDate:(id)sender{
   
    
    UIBarButtonItem *bar =(UIBarButtonItem*)sender;
    if (popController == nil){
        PopupDateViewController *date = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
        date.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:date];
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        self.popController = popover;
        [popover release];
        [nav release];
    }
    [popController dismissPopoverAnimated:YES];
    [popController presentPopoverFromBarButtonItem:bar permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{
    [popController dismissPopoverAnimated:YES];
    if(bSaved){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        if ([dateString isEqualToString:@"2013-12-30"]) {
            dateString = @"2012-12-30";
        }
        else if([dateString isEqualToString:@"2013-12-31"]) {
            dateString = @"2012-12-31";
        }

        self.showDate = dateString;
        [dateFormatter release];
        [self requestDetailDatas];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = pointName;
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,160, 44)];
    
    UIBarButtonItem *aButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选取日期"
                                                                    style:UIBarButtonItemStyleBordered target:self action:@selector(chooseDate:)];
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithTitle:@"表格详情"
                                                                   style:UIBarButtonItemStyleBordered target:self action:@selector(chooseMoreDetail:)];
    
    toolBar.items = [NSArray arrayWithObjects:aButtonItem,detailItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    
    [detailItem release];
	[aButtonItem release];
    [toolBar release];

    self.dataTableView = [[[UITableView alloc] initWithFrame:CGRectMake(11, 500, 289, 421)style:UITableViewStyleGrouped] autorelease];
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    
    self.resultWebView = [[[UIWebView alloc] initWithFrame:CGRectMake(305, 500, 452, 421)] autorelease];
    [self.view addSubview:resultWebView];
    self.html = [NSMutableString string];
    self.graphView = [[[S7GraphView alloc] initWithFrame:CGRectMake(11, 19, 746, 431)] autorelease];
	self.graphView.dataSource = self;
	NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMinimumFractionDigits:0];
	[numberFormatter setMaximumFractionDigits:0];
	
	self.graphView.yValuesFormatter = numberFormatter;
    
	[numberFormatter release];
	
	self.graphView.backgroundColor = [UIColor whiteColor];
	
	self.graphView.drawAxisX = YES;
	self.graphView.drawAxisY = YES;
	self.graphView.drawGridX = YES;
	self.graphView.drawGridY = YES;
	
	self.graphView.xValuesColor = [UIColor blackColor];
	self.graphView.yValuesColor = [UIColor blackColor];
	
	self.graphView.gridXColor = [UIColor blackColor];
	self.graphView.gridYColor = [UIColor blackColor];
	
	self.graphView.drawInfo = YES;
	self.graphView.infoColor = [UIColor blackColor];
    
    [self.view addSubview:graphView];
    
    isGetDate = YES;//是否是在获取有效日期
    [self requestDetailDatas];
}

#pragma mark - 表格详情

-(void)chooseMoreDetail:(UIBarButtonItem *)sender{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setObject:@"QUERY_WATER_STATION_TABLEDETAIL" forKey:@"service"];
    [params setObject:curType forKey:@"type"];
    [params setObject:showDate forKey:@"date"];
    [params setObject:pointCode forKey:@"portId"];
    [params setObject:pointName forKey:@"portName"];
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params ignoreClientType:NO];
    xfMoreDetailViewController * moreDetail = [[xfMoreDetailViewController alloc] initWithNibName:@"xfMoreDetailViewController" bundle:nil];
    moreDetail.detailUrl = strUrl;
    moreDetail.isMonitor = YES;
    [self.navigationController pushViewController:moreDetail animated:YES];
    [moreDetail release];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    if (webHelper) {
        [webHelper cancel];
    }
    [popController dismissPopoverAnimated:YES];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
	[super viewDidAppear:animated];
}

#pragma mark protocol S7GraphViewDataSource

- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView {
	/* Return the number of plots you are going to have in the view. 1+ */
    
	if ( 0 == [aryDataValues count]) {
		return 0;//还未取到数据
	}
	return 1;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView {
	/* An array of objects that will be further formatted to be displayed on the X-axis.
	 The number of elements should be equal to the number of points you have for every plot. */
    
    NSMutableArray* ary = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    for (int i = 0; i < [aryDataValues count]; i++) {
        NSDictionary *dic = [aryDataValues objectAtIndex:i];
        NSString *value = [dic objectForKey:@"X"];
        [ary addObject:value];
    }
	return ary;

}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex {
	
    NSMutableArray* ary = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    for (int i = 0; i < [aryDataValues count]; i++) {
        NSDictionary *dic = [aryDataValues objectAtIndex:i];
        NSString *value = [dic objectForKey:curYinziName];
        [ary addObject:[NSNumber numberWithFloat:[value floatValue]]];
    }
	
	return ary;

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    /*NSArray *keys = [resultDataDic allKeys];
     NSArray *aryTmp = [resultDataDic objectForKey:[keys objectAtIndex:section]];
     return [aryTmp count];
     */
    return [aryYinziNames count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"监测因子";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    cell.textLabel.text = [[aryYinziNames objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    self.curYinziName = [[aryYinziNames objectAtIndex:indexPath.row] objectForKey:@"id"];
    if ([curYinziName isEqualToString:@"pH"]) {
        graphView.special = YES;
    }
    else{
        graphView.special = NO;
    }

    [self refreshWebView];
 //   [self.dataTableView reloadData];
    
}



@end
