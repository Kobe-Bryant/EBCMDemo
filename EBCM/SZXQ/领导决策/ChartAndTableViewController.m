//
//  ChartAndTableViewController.m
//  SZXQ
//
//  Created by ihumor on 13-5-13.
//  Copyright (c) 2013年 ihumor. All rights reserved.
//

#import "ChartAndTableViewController.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"
#import <QuartzCore/QuartzCore.h>
#import "PaiKouTableViewController.h"
#import "QYDAItemDetaiViewController.h"

#define LIGHT_BLUE_UICOLOR2 [UIColor colorWithRed:(0xf2/255.0f) green:(0xf0/255.0f) blue:(0xec/255.0f) alpha:1.0]

@interface ChartAndTableViewController ()<paiKouTableDelegate>{
    
    NSMutableString *html;
}
@property (nonatomic, copy) NSString *curYinziName;
@property (nonatomic, strong) NSMutableArray *yinZiArr;
@property (nonatomic, assign) int curType;
@property (nonatomic,strong) UIPopoverController *fujianPopover;

@end

@implementation ChartAndTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.curType = 0;
        
        self.resultAry = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
        self.itemAry = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
        self.yinZiArr = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
        html = [[NSMutableString alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addAllView];
    [self requestData];
    
}

- (void)addAllView
{
    UISegmentedControl *segm = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"蓝藻日报",@"蓝藻周报",@"蓝藻月报",@"蓝藻年报", nil]];
    [segm setFrame:CGRectMake(184.0,7.0, 400.0, 30.0)];
    [segm addTarget:self action:@selector(clickOnSegm:) forControlEvents:UIControlEventValueChanged];
    segm.segmentedControlStyle = UISegmentedControlStyleBar;
    segm.selectedSegmentIndex = _curType;
    self.navigationItem.titleView = segm;
    [segm release];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"查看附件" style:UIBarButtonItemStyleBordered target:self action:@selector(clickOnItem:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
    self.graphView = [[[S7GraphView alloc] initWithFrame:CGRectMake(10, 20, 748, 461)] autorelease];
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
    
    [self.view addSubview:_graphView];
    
}

- (void)clickOnSegm:(UISegmentedControl *)seg
{
    _curType = seg.selectedSegmentIndex;
    [self requestData];
}

- (void)clickOnItem:(id)sender{
    
    _curType = -1;
    [self requestData];
    
}

-(void)requestData{
 
    if (self.isLoading) {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    if (_curType==-1) {
        //获取附件
        [params setObject:@"QUERY_LZYBFJ" forKey:@"service"];
        [params setObject:@"1" forKey:@"currentPage"];
    }
    else{
        [params setObject:@"QUERY_LZTJ" forKey:@"service"];
        [params setObject:@"chart" forKey:@"viewType"];
    }
    
    switch (_curType) {
        case -1:
            [params setObject:@"data" forKey:@"type"];
            break;
        case 0:
            [params setObject:@"day" forKey:@"type"];
            break;
        case 1:
            [params setObject:@"week" forKey:@"type"];
            break;
        case 2:
            [params setObject:@"month" forKey:@"type"];
            break;
        case 3:
            [params setObject:@"year" forKey:@"type"];
            break;
        default:
            break;
    }
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
    _isLoading = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    
    if (_urlConnHelper) {
        [_urlConnHelper cancel];
    }
    if (_fujianPopover) {
        [_fujianPopover dismissPopoverAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)processWebData:(NSData*)webData{
    
    _isLoading = NO;
    if (_resultAry.count>0) {
        [_resultAry removeAllObjects];
    }
    if (_yinZiArr.count>0) {
        [_yinZiArr removeAllObjects];
    }
    
    if([webData length] <=0 )
        return;
    NSString *resultJSON = [[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    NSArray *aryDate = [resultJSON objectFromJSONString];
    if (aryDate == nil||[aryDate count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [_table reloadData];
        return;
    }
    [_resultAry addObjectsFromArray:aryDate];
    if (_curType ==-1) {
        
        if (_fujianPopover) {
            [_fujianPopover dismissPopoverAnimated:YES];
        }
      
        PaiKouTableViewController *controller = [[PaiKouTableViewController alloc] initWithStyle:UITableViewStylePlain AndInfoArr:_resultAry AndCurSelect:-1];
        controller.delegage = self;
        controller.curWuRanType = 5;
       
        UIPopoverController *popCtrl1 = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popCtrl1 setPopoverContentSize:CGSizeMake(600.0, 400.0)];
        self.fujianPopover = popCtrl1;
        [controller release];
        [popCtrl1 release];
        
        [_fujianPopover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        return;
        
    }
    
    NSDictionary *dic = [_resultAry objectAtIndex:0];
    NSArray *arr = [dic allKeys];
    for (NSString *keyName in arr) {
        if (![keyName isEqualToString:@"sj"]) {
            if (![keyName isEqualToString:@"formatTime"]) {
                if (![keyName isEqualToString:@"formatTime1"]) {
                    [_yinZiArr addObject:keyName];
                }
            }
        }
    }
    for (NSString *str in _yinZiArr) {
        if ([str isEqualToString:@"藻密度"]) {
            [_yinZiArr exchangeObjectAtIndex:0 withObjectAtIndex:[_yinZiArr indexOfObject:str]];
            break;
        }
    }
    if (_yinZiArr.count >0) {
        _curYinziName = [[_yinZiArr objectAtIndex:0] retain];
        [_table reloadData];
        [self tableView:_table didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
   
   
}


#pragma mark - PaiKouTableViewController的delegate处理

-(void)didSelectPaiKou:(NSDictionary *)PaiKouDic AndCurSelect:(int)curtag{
    
    QYDAItemDetaiViewController *controller = [[QYDAItemDetaiViewController alloc] initWithNibName:@"QYDAItemDetaiViewController" bundle:nil];
    controller.fjUrlStr = [NSString stringWithFormat:@"http://218.4.75.114:8080/ebcm_net_szxq/UploadFile/lzzbfj/%@",[PaiKouDic objectForKey:@"FileName"]];
    controller.filePath = [PaiKouDic objectForKey:@"FileName"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

    
    
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
    _isLoading = NO;
    return;
}

#pragma mark protocol S7GraphViewDataSource

- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView {
	/* Return the number of plots you are going to have in the view. 1+ */
    
	if ( 0 == [_resultAry count]) {
		return 0;//还未取到数据
	}
	return 1;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView {
	/* An array of objects that will be further formatted to be displayed on the X-axis.
	 The number of elements should be equal to the number of points you have for every plot. */
    
    NSMutableArray* ary = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    for (int i = 0; i < [_resultAry count]; i++) {
        NSDictionary *dic = [_resultAry objectAtIndex:i];
        NSString *str = [dic objectForKey:@"sj"];
        NSString *value = @"";
        switch (_curType) {
            case 0:
            {
                value = [NSString stringWithFormat:@"%@   %@:00",[str substringToIndex:10],[dic objectForKey:@"formatTime"]];
            }
                break;
            case 1:
            {
                value = [NSString stringWithFormat:@"%@ %@",[str substringToIndex:10],[dic objectForKey:@"formatTime"]];
            }
                break;
                
            case 2:
            {
                value = [NSString stringWithFormat:@"%@%@",[str substringToIndex:5],[dic objectForKey:@"formatTime"]];
            }
                break;
                
            case 3:
            {
                value = [dic objectForKey:@"formatTime"];
            }
                break;
                
                
            default:
                break;
        }
        [ary addObject:value];
    }
	return ary;
    
}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex {
	
    NSMutableArray* ary = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    for (int i = 0; i < [_resultAry count]; i++) {
        NSDictionary *dic = [_resultAry objectAtIndex:i];
        NSString *value = [dic objectForKey:_curYinziName];
        [ary addObject:[NSNumber numberWithFloat:[value floatValue]]];
    }
	
	return ary;
    
}



-(void)refreshWebView{
    
    if (html.length>0) {
        [html setString:@""];
    }
    NSString *width = @"452px";
    [html appendFormat:@"<html><body topmargin=0 leftmargin=0><table width=\"%@\" bgcolor=\"#FFCC32\" border=1 bordercolor=\"#893f7e\" frame=below rules=none><tr><th><font color=\"Black\">%@监测详细信息</font></th></tr><table><table width=\"%@\" bgcolor=\"#893f7e\" border=0 cellpadding=\"1\"><tr bgcolor=\"#e6e7d5\" ><th>监测时间</th><th>监测数据</th></tr>",width,_curYinziName,width];
    
    BOOL boolColor = true;
    
    for (int i = [_resultAry count]-1; i >=0 ; i--) {
        NSDictionary *dicValue = [_resultAry objectAtIndex:i];
        NSString *time = @"";
        NSString *str = [dicValue objectForKey:@"sj"];
        switch (_curType) {
            case 0:
            {
                time = [NSString stringWithFormat:@"%@   %@:00",[str substringToIndex:10],[dicValue objectForKey:@"formatTime"]];
            }
                break;
            case 1:
            {
                 time = [NSString stringWithFormat:@"%@ %@",[str substringToIndex:10],[dicValue objectForKey:@"formatTime"]];
            }
                break;

            case 2:
            {
                time = [NSString stringWithFormat:@"%@%@",[str substringToIndex:5],[dicValue objectForKey:@"formatTime"]];
            }
                break;

            case 3:
            {
                time = [dicValue objectForKey:@"formatTime"];
            }
                break;

                
            default:
                break;
        }
        NSString * value = @"--";
        if ([dicValue objectForKey:_curYinziName]!=nil) {
            float val = [[dicValue objectForKey:_curYinziName] floatValue];
            value = [NSString stringWithFormat:@"%0.2f",val];
        }
        
        [html appendFormat:@"<tr bgcolor=\"%@\">",boolColor ? @"#cfeeff" : @"#ffffff"];
        boolColor = !boolColor;
        [html appendFormat:@"<td align=center>%@</td><td align=center>%@</td>",time ,value];
        [html appendString:@"</tr>"];
        
    }
    
    [html appendString:@"</table></body></html>"];
    
    //添加webview
    [self.webView loadHTMLString:html baseURL:nil];
    [self addView:self.webView type:@"pageCurl" subType:kCATransitionFromRight];
    
    //添加统计图
    _graphView.info = @"";
    [_graphView reloadData];
    [self addView:_graphView type:@"rippleEffect" subType:kCATransitionFromTop];
    
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



#pragma mark - Table View

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"监测因子";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _yinZiArr.count;
}



- (void)tableView:(UITableView *)aTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR2;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_yinZiArr objectAtIndex:indexPath.row];
    if ([cell.textLabel.text isEqualToString:_curYinziName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    self.curYinziName = [[_yinZiArr objectAtIndex:indexPath.row] retain];
    if ([_curYinziName isEqualToString:@"PH值"]) {
        _graphView.special = YES;
    }
    else{
        _graphView.special = NO;
    }
    
    [self refreshWebView];
 //   [_table reloadData];
}

- (void)dealloc {

    [_yinZiArr release];
    [_graphView release];
    [_urlConnHelper release];
    [_itemAry release];
    [_resultAry release];
    [_table release];
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTable:nil];
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
