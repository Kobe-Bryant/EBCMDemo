//
//  MonitorDetailViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MonitorDetailViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "xfMoreDetailViewController.h"

@interface MonitorDetailViewController ()

@end



@implementation MonitorDetailViewController
@synthesize webservice,aItemInfo,seldate;
@synthesize dataTableView,resultWebView,keyAry,graphView;
@synthesize valueAry,childViewController,listTable,wtype,html,qybh,qymc;

#pragma mark - Private methods

-(void)requestData{
      
    if(aItemInfo){
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
        
        if (getLatestDate) {
            
            [params setObject:@"QUERY_ONLINE_SITES_DATE" forKey:@"service"];
            [params setObject:@"1" forKey:@"getLatestDate"];
        }
        else{
            [params setObject:@"QUERY_ONLINE_SITES_CHART_DETAIL" forKey:@"service"];
        }

        
        [params setObject:[typeArr objectAtIndex:self.wtype] forKey:@"type"];
        [params setObject:[outputTypeArr objectAtIndex:self.wtype] forKey:@"outputTypeName"];
        [params setObject:self.qymc forKey:@"qyname"];
        [params setObject:self.qybh forKey:@"qybh"];
        
         if (self.wtype == fsyTYPE){
            [params setObject:[[aItemInfo objectAtIndex:curPaiKouSelect] objectForKey:@"排放口编号"] forKey:@"dischargePortId"];
           
        }
         else{
             [params setObject:[[aItemInfo objectAtIndex:curPaiKouSelect] objectForKey:@"排口编号"] forKey:@"dischargePortId"];
         }
     
        NSArray *tmpAry = [seldate componentsSeparatedByString:@"-"];
        if([tmpAry count] >=3){
            [params setObject:[tmpAry objectAtIndex:0] forKey:@"year"];
            [params setObject:[tmpAry objectAtIndex:1] forKey:@"month"];
            [params setObject:[tmpAry objectAtIndex:2] forKey:@"day"];
        }
        
        NSString *strUrl = [ServiceUrlString generateUrlByParameters:params ignoreClientType:YES];
        
        self.webservice = [[[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self] autorelease];
    }
    
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        curPaiKouSelect = 0;
    }
    return self;
}

-(void)refreshWebView{
    
    
    NSString *width = @"452px";
    NSString *unit = @"";
    if(html == nil)
        self.html = [NSMutableString stringWithCapacity:300];
    [html setString:@""];
    [html appendFormat:@"<html><body topmargin=0 leftmargin=0><table width=\"%@\" bgcolor=\"#FFCC32\" border=1 bordercolor=\"#893f7e\" frame=below rules=none><tr><th><font color=\"Black\">%@监测详细信息</font></th></tr><table><table width=\"%@\" bgcolor=\"#893f7e\" border=0 cellpadding=\"1\"><tr bgcolor=\"#e6e7d5\" ><th>监测时间</th><th>监测数据</th></tr>",width,self.curKey,width];
    
    BOOL boolColor = true;

    for (int i = [valueAry count]-1; i >=0 ; i--) {
        NSDictionary *dicValue = [valueAry objectAtIndex:i];
        NSString *time = [NSString stringWithFormat:@"%@ %@",seldate,[dicValue objectForKey:@"X"]];
        NSString * value = @"--";
        if ([dicValue objectForKey:self.curKey]!=nil) {
            float val = [[dicValue objectForKey:self.curKey] floatValue];
            NSString * valStr = [NSString stringWithFormat:@"%0.2f",val];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = qymc;
    getLatestDate = YES;
    curPaiKouSelect = 0;
    //弹出列表初始化设置
    UITableView * listTab = [[UITableView alloc] initWithFrame:CGRectMake(768-226, 67, 228, 893) style:UITableViewStyleGrouped];
    self.listTable = listTab;
    
    UIImageView *listImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f2f2f2(960).png"]] autorelease];
    [listTable.backgroundView addSubview:listImage];
    [listTab release];
    //列表初始化
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(11, 503, 289, 421) style:UITableViewStyleGrouped];
    self.dataTableView = tableview;
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    [tableview release];
    
    //webView初始化
    UIWebView * web = [[UIWebView alloc] initWithFrame:CGRectMake(305, 504, 452, 421)];
    self.resultWebView = web;
    [web release];
    
    //统计图初始化
    S7GraphView * graph  = [[S7GraphView alloc] initWithFrame:CGRectMake(11, 19, 746, 461)];
	graph.dataSource = self;
    self.graphView = graph;
    [graph release];
	NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setMinimumFractionDigits:1];
	[numberFormatter setMaximumFractionDigits:1];
	
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
   
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,210, 44)];
    UIBarButtonItem *paikouItem = [[UIBarButtonItem alloc] initWithTitle:@"排口"
                                                                   style:UIBarButtonItemStyleBordered target:self action:@selector(selectPaiKou)];
    
    UIBarButtonItem *aButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选取日期"
                                                                    style:UIBarButtonItemStyleBordered target:self action:@selector(searchAvailableDate)];
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithTitle:@"表格详情"
                                                                    style:UIBarButtonItemStyleBordered target:self action:@selector(chooseMoreDetail:)];
    
    toolBar.items = [NSArray arrayWithObjects:paikouItem,aButtonItem,detailItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    [toolBar release];
    [paikouItem release];
    [aButtonItem release];
    [detailItem release];
    
    typeArr = [[NSArray alloc] initWithObjects:@"fs",@"fs",@"fs",@"fq",@"fq",@"fsjk",@"fs", nil];
    outputTypeArr = [[NSArray alloc] initWithObjects:@"一般排污口",@"重金属排口",@"污水处理厂排口",@"0",@"1",@"",@"固废排口",nil];
    
    [self requestData];

}

#pragma mark - 表格详情

-(void)chooseMoreDetail:(UIBarButtonItem *)sender{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setObject:@"QUERY_ONLINE_SITES_TABLE_DETAIL" forKey:@"service"];
    [params setObject:[typeArr objectAtIndex:self.wtype] forKey:@"type"];
    [params setObject:[outputTypeArr objectAtIndex:self.wtype] forKey:@"outputTypeName"];
    [params setObject:self.qymc forKey:@"qyname"];
    [params setObject:self.qybh forKey:@"qybh"];
    
    if (self.wtype == fsyTYPE){
        [params setObject:[[aItemInfo objectAtIndex:curPaiKouSelect] objectForKey:@"排放口编号"] forKey:@"dischargePortId"];
    }
    else{
        [params setObject:[[aItemInfo objectAtIndex:curPaiKouSelect] objectForKey:@"排口编号"] forKey:@"dischargePortId"];
    }
   
    NSArray *tmpAry = [seldate componentsSeparatedByString:@"-"];
    if([tmpAry count] >=3){
        [params setObject:[tmpAry objectAtIndex:0] forKey:@"year"];
        [params setObject:[tmpAry objectAtIndex:1] forKey:@"month"];
        [params setObject:[tmpAry objectAtIndex:2] forKey:@"day"];
    }
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params ignoreClientType:NO];
    xfMoreDetailViewController * moreDetail = [[xfMoreDetailViewController alloc] initWithNibName:@"xfMoreDetailViewController" bundle:nil];
    moreDetail.detailUrl = strUrl;
    moreDetail.isMonitor = YES;
    [self.navigationController pushViewController:moreDetail animated:YES];
    [moreDetail release];
    
}

#pragma mark - PaiKouTableViewController的delegate处理

-(void)didSelectPaiKou:(NSDictionary *)PaiKouDic AndCurSelect:(int)curtag{
    
    curPaiKouSelect = curtag;
    [popover dismissPopoverAnimated:YES];
    [popover autorelease];
    [self requestData];
    
    
}


#pragma mark - 选择排口
-(void)selectPaiKou{
    
    if (popover) {
        [popover dismissPopoverAnimated:YES];
    }
    
    PaiKouTableViewController *controller = [[PaiKouTableViewController alloc] initWithStyle:UITableViewStylePlain AndInfoArr:aItemInfo AndCurSelect:curPaiKouSelect];
    controller.delegage = self;
    if (self.wtype == fswryTYPE) {
        controller.curWuRanType = 1;
    }
    else if (self.wtype ==fsyTYPE) {
        controller.curWuRanType = 2;
    }

    popover = [[FPPopoverController alloc] initWithViewController:controller];
    [controller release];
     popover.contentSize = CGSizeMake(200, 300);
    popover.tint = FPPopoverLightGrayTint;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:locationView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    locationView = [[UIView alloc] initWithFrame:CGRectMake(562.5, 4.0, 35.0, 32.0)];
    locationView.userInteractionEnabled = NO;
    locationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:locationView];
    [locationView release];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    if (webservice)
        [webservice cancel];
    [locationView removeFromSuperview];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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

#pragma mark - NSURLConnHelper delegate

-(void)processWebData:(NSData*)webData
{
    
    NSString *receivedStr =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    if (getLatestDate) {
        self.seldate = [self fitDateStr:receivedStr];
        getLatestDate = NO;
        [self requestData];
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
        NSString * uplineStr = [infDic objectForKey:@"ceiling"];
        NSString * downlineStr = [infDic objectForKey:@"floor"];
        NSMutableDictionary * lastDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [lastDic setValue:keyName forKey:@"id"];
        [lastDic setValue:displayKeyName forKey:@"name"];
        [lastDic setValue:orderNum forKey:@"order"];
        [lastDic setValue:uplineStr forKey:@"up"];
        [lastDic setValue:downlineStr forKey:@"down"];
        [sortArr addObject:lastDic];
    }
    NSSortDescriptor* sortByA = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:NO];
    [sortArr sortUsingDescriptors:[NSArray arrayWithObject:sortByA]];
    self.keyAry = sortArr;
    
    
    
    NSArray * receivedAry = [receiveDic objectForKey:@"data"];
    if (receivedAry.count==0) {
     
        NSString * msg = nil;
        
        if (seldate!=nil) {
             msg = [NSString stringWithFormat:@"未找到%@的实时监测数据!",seldate];
        }
        else{
            msg = @"未找到实时监测数据!";
        }
        
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
        
        self.valueAry = arr;
        if (self.graphView.superview)
            [graphView removeFromSuperview];
        if (self.resultWebView.superview)
            [resultWebView removeFromSuperview];
        [self addView:self.dataTableView type:kCATransitionPush subType:kCATransitionFromLeft];
        self.curKey = [[keyAry objectAtIndex:0] objectForKey:@"id"];
        [self refreshWebView];
        [self.dataTableView reloadData];
        float upline = [[[keyAry objectAtIndex:0] objectForKey:@"up"] floatValue];
        if (upline>0) {
            self.graphView.yHighLimit = upline;
            float downline = [[[keyAry objectAtIndex:0] objectForKey:@"down"] floatValue];
             self.graphView.yLowLimit = downline;
        }
        
        if ([_curKey isEqualToString:@"PH"]) {
            graphView.special = YES;
        }
        else{
            graphView.special = NO;
        }

        [self.graphView reloadData];
        [self.dataTableView reloadData];
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
                          message:@"传输数据失败,请检查网络连接并重试。" 
                          delegate:nil 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    getLatestDate = NO;
}

- (void)searchAvailableDate
{
    if (bDetailShow)
    {
        [self hideDetailController:YES];
    }
    else
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
        [params setObject:@"QUERY_ONLINE_SITES_DATE" forKey:@"service"];
        [params setObject:[typeArr objectAtIndex:self.wtype] forKey:@"type"];
        [params setObject:[outputTypeArr objectAtIndex:self.wtype] forKey:@"outputTypeName"];
        [params setObject:self.qymc forKey:@"qyname"];
        [params setObject:self.qybh forKey:@"qybh"];
        
        if (self.wtype == fsyTYPE){
            [params setObject:[[aItemInfo objectAtIndex:curPaiKouSelect] objectForKey:@"排放口编号"] forKey:@"jczid"];
        }
        else{
            [params setObject:[[aItemInfo objectAtIndex:curPaiKouSelect] objectForKey:@"排口编号"] forKey:@"jczid"];
        }
        
        NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
        
        AvailableDateListVC *controller = [[AvailableDateListVC alloc] initWithUrl:strUrl andDelegate:self andParseType:1];
        controller.dateTable = listTable;
        [self showDetailController:controller animated:YES];
    }
}

-(void)showDetailController:(AvailableDateListVC *)viewController animated:(BOOL)animated
{
	if(childViewController && childViewController.view.superview != nil)
	{
		[self hideDetailController:YES];
	}
    
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.childViewController = nc;
    nc.delegate = self;
    [nc release];
    
    nc.view.frame = CGRectMake(768 - 228, 0, 441, 960);
    listTable.alpha = 1;
    listTable.frame = CGRectMake(768 - 226, 67, 228, 960);
    viewController.view.frame = CGRectMake(0, 0, nc.view.frame.size.width, nc.view.frame.size.height - 44);
	
    //添加手势 向右滑的手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeFromLeft)];
    swipeGesture.direction =  UISwipeGestureRecognizerDirectionRight;
    [nc.view addGestureRecognizer:swipeGesture];
    [swipeGesture release];
	
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detailView_left_shadow.png"]];
    iv.frame = CGRectMake(-25, 0, 27, nc.view.frame.size.height);
    [nc.view addSubview:iv];
    [iv release];
	
    [nc willAnimateRotationToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:1.0];
    
	if(animated)
	{
		CATransition *transition = [CATransition animation];
		transition.duration = 0.4;
		transition.delegate = nil;
		transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		transition.type = kCATransitionPush;
		transition.subtype = kCATransitionFromRight;
		[childViewController.view.layer addAnimation:transition forKey:nil];
        [listTable.layer addAnimation:transition forKey:nil];
	}
	
	[self.view addSubview:nc.view];
    [self.view addSubview:listTable];
    
    bDetailShow = YES;
}

#pragma mark - Private methods

-(void)hideDetailController:(BOOL)animated
{
    if(animated)
    {
        [UIView beginAnimations:@"hidedetailcontroller" context:nil];
        [UIView	setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        CGRect rect = CGRectZero;
        
        rect = CGRectMake(768, 0, 228, 960);
        
        CGRect rect2 = CGRectZero;
        rect2 = CGRectMake(768+226, 67, 310, 960);
        
        childViewController.view.alpha = 0;
        childViewController.view.frame = rect;
        
        listTable.alpha = 0;
        listTable.frame = rect2;
        
        [UIView commitAnimations];
    }
    
    else
    {
        [childViewController.view removeFromSuperview];
        [childViewController release];
        self.childViewController  = nil;
    }
    
    bDetailShow = NO;
}

-(void)detailSwipeFromLeft
{
	if(childViewController == nil || childViewController.view.superview == nil)
	{
		return;
	}
	[self hideDetailController:YES];
	/*
     //detailcontroller 不是导航控制器
     if(![detailController isKindOfClass:[UINavigationController class]])
     {
     [self hideDetailController:YES];
     }
     
     //detailconroller是导航控制器
     
     UINavigationController *nc = (UINavigationController *)detailController;
     
     if(nc.viewControllers.count == 1)
     {
     [self hideDetailController:YES];
     }
     
     else {
     [nc popViewControllerAnimated:YES];
     }
     */
}


#pragma mark protocol S7GraphViewDataSource

- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView {
	/* Return the number of plots you are going to have in the view. 1+ */
	if (valueAry == nil || 0 == [valueAry count]) {
		return 0;//还未取到数据
	}
	return 1;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView {
	/* An array of objects that will be further formatted to be displayed on the X-axis.
	 The number of elements should be equal to the number of points you have for every plot. */
    
	NSMutableArray* ary = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    
    
    for (int i = 0; i < [valueAry count]; i++) {
        NSDictionary *dic = [valueAry objectAtIndex:i];
        NSString *value = [dic objectForKey:@"X"];
        [ary addObject:value];
    }
	return ary;
}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex {
    
    NSMutableArray* ary = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    for (int i = 0; i < [valueAry count]; i++) {
        NSDictionary *dic = [valueAry objectAtIndex:i];
        NSString *value = [dic objectForKey:self.curKey];
        [ary addObject:[NSNumber numberWithFloat:[value floatValue]]];
    }
	
	return ary;

}

-(void)dealloc{
    
    [outputTypeArr release];
    [typeArr release];
    [aItemInfo release];
    [seldate release];
    [dataTableView release];
    [resultWebView release];
    [keyAry release];
    [graphView release];
    [valueAry release];
    [childViewController release];
    [listTable release];
    [html release];

    [_curKey release];
    [qybh release];
    [qymc release];
    [super dealloc];
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
    return [keyAry count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"监测因子";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"defaultcell"] autorelease];

    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = [[keyAry objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;    
}


#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (bDetailShow) {
        [self hideDetailController:YES];
    }
    
    self.curKey = [[keyAry objectAtIndex:indexPath.row] objectForKey:@"id"];
    if ([_curKey isEqualToString:@"PH"]) {
        graphView.special = YES;
    }
    else{
        graphView.special = NO;
    }
    [self refreshWebView];
   // [self.dataTableView reloadData];
    
}


#pragma mark - AvailableDate delegate

- (void)returnAvailableDate:(NSString *)dateString;
{
    [self hideDetailController:YES];
    
    if (dateString != nil)
    {
        self.seldate = [self fitDateStr:dateString];
        [self requestData];
    }
}

@end
