//
//  MBRWViewController.m
//  SZXQ
//
//  Created by ihumor on 13-5-15.
//  Copyright (c) 2013年 ihumor. All rights reserved.
//

#import "MBRWViewController.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"
#import "NTChartView.h"
#import "ChartItem.h"

@interface MBRWViewController (){
    
    UILabel *titleLb1;
    UILabel *titleLb2;
}
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, strong) NSDictionary *resultDic;
@property (nonatomic, retain) NTChartView *ZDXMchartView;
@property (nonatomic, retain) NTChartView *SSGCchartView;
@property (nonatomic, retain) NSMutableArray * ZDXMitemAry;
@property (nonatomic, retain) NSMutableArray * SSGCitemAry;

@end

@implementation MBRWViewController

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"目标任务";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"选择时间" style:UIBarButtonItemStyleBordered target:self action:@selector(chooseDate:)];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
    
    titleLb1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 2.0, 768.0, 20.0)];
    titleLb1.textAlignment = UITextAlignmentCenter;
    titleLb1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLb1];
    [titleLb1 release];
    
    
    
    titleLb2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 327.0, 768.0, 20.0)];
    titleLb2.backgroundColor = [UIColor clearColor];
    titleLb2.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:titleLb2];
    [titleLb2 release];
    
    self.ZDXMchartView = [[[NTChartView alloc] initWithFrame:CGRectMake(10, 25, 748.0,300.0)] autorelease];
    [self.view addSubview:_ZDXMchartView];
    
    self.SSGCchartView = [[[NTChartView alloc] initWithFrame:CGRectMake(10, 350.0, 748.0,300.0)] autorelease];
    [self.view addSubview:_SSGCchartView];
    
    PopupDateViewController *dateCtrl = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
    self.dateSelectCtrl = dateCtrl;
    _dateSelectCtrl.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_dateSelectCtrl];
    UIPopoverController *popCtrl1 = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.datePopover = popCtrl1;
    [dateCtrl release];
    [nav release];
    [popCtrl1 release];
    self.ZDXMitemAry = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    self.SSGCitemAry = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    
    [self requestData];
    
    
}

-(void)refreshDatasByIndex:(NSInteger)index{
    
    NSMutableArray *colorAry = [[ChartItem makeColorArray] retain];//不加retain会释放掉出错
    int colorIndex = 1;
    
    if (_ZDXMitemAry.count>0) {
        [_ZDXMitemAry removeAllObjects];
        [_ZDXMchartView clearItems];
        [_ZDXMchartView setNeedsDisplay];
    }
    
    if (_SSGCitemAry.count>0) {
        [_SSGCitemAry removeAllObjects];
        [_SSGCchartView clearItems];
        [_SSGCchartView setNeedsDisplay];
    }
    
    NSArray *zdxmArr = nil;
    NSArray *ssgcArr = nil;
    id object =  [_resultDic objectForKey:@"重点项目"];
    if ([object isKindOfClass:[NSArray class]]) {
        zdxmArr = [_resultDic objectForKey:@"重点项目"];
    }
   
    id object1 =  [_resultDic objectForKey:@"实事工程"];
    if ([object1 isKindOfClass:[NSArray class]]) {
        ssgcArr = [_resultDic objectForKey:@"实事工程"];
    }

    NSString *str = @"";
    NSString *names = @"";
   
    if (zdxmArr!=nil&&[zdxmArr count]>0 ){
        for (int i=0; i<[zdxmArr count]; i++) {
            str = [NSString stringWithFormat:@"%@",[[zdxmArr objectAtIndex:i] objectForKey:@"LJWC"]];
            names = [NSString stringWithFormat:@"%@",[[zdxmArr objectAtIndex:i] objectForKey:@"RWMC"]];
            CGFloat value = [str floatValue];
            if (value > 0) {
                colorIndex ++;
                if (colorIndex >13) {
                    colorIndex = 2;
                }
            }else{
                colorIndex = 1;
            }
            UIColor *color = [colorAry objectAtIndex:colorIndex];
            ChartItem *aItem = [ChartItem itemWithValue:value Name:names Color:color.CGColor];
            [_ZDXMitemAry addObject:aItem];
        }
        [_ZDXMchartView addGroupArray:_ZDXMitemAry withGroupName:names];
        [_ZDXMchartView setNeedsDisplay];
        
    }
    
    if (ssgcArr !=nil &&[ssgcArr count]>0 ){
        for (int i=0; i<[ssgcArr count]; i++) {
            
            str = [NSString stringWithFormat:@"%@",[[ssgcArr objectAtIndex:i] objectForKey:@"LJWC"]];
            names = [NSString stringWithFormat:@"%@",[[ssgcArr objectAtIndex:i] objectForKey:@"RWMC"]];
            CGFloat value = [str floatValue];
            if (value > 0) {
                colorIndex ++;
                if (colorIndex >13) {
                    colorIndex = 2;
                }
            }else{
                colorIndex = 1;
            }
            UIColor *color = [colorAry objectAtIndex:colorIndex];
            ChartItem *aItem = [ChartItem itemWithValue:value Name:names Color:color.CGColor];
            [_SSGCitemAry addObject:aItem];
        }
        [_SSGCchartView addGroupArray:_SSGCitemAry withGroupName:names];
        [_SSGCchartView setNeedsDisplay];
        
    }

}


- (void)chooseDate:(id)sender{
    
    if (_datePopover)
        [_datePopover dismissPopoverAnimated:YES];
    UIBarButtonItem *item = (UIBarButtonItem *)sender;
    [_datePopover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - PopoverDate delegate

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date;
{
    
    if (bSaved) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSArray *arr = [dateString componentsSeparatedByString:@"-"];
        self.year = [arr objectAtIndex:0];
        self.month = [arr objectAtIndex:1];
        [self requestData];
       
    }
     [_datePopover dismissPopoverAnimated:YES];
}


-(void)requestData{
    
    if (self.isLoading) {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_ZDXMHSSGC" forKey:@"service"];
    if (_year.length >0) {
         [params setObject:_year forKey:@"year"];
    }
    if (_month.length >0) {
        [params setObject:_month forKey:@"month"];
    }
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@&viewType=chart",urlStr];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr1 andParentView:self.view delegate:self] autorelease];
    NSURL *url = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    _isLoading = YES;
    
   
}

-(void)processWebData:(NSData*)webData{
    
    _isLoading = NO;
    if([webData length] <=0 )
        return;
    NSString *resultJSON = [[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    self.resultDic = [resultJSON objectFromJSONString];
    if (_resultDic == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSString *yearStr = [_resultDic objectForKey:@"年"];
    NSString *monthStr = [_resultDic objectForKey:@"月"];
    if (yearStr!=nil&&monthStr!=nil) {
        titleLb1.text = [NSString stringWithFormat:@"苏州高新区%@年%@月重点项目进度图表",yearStr,monthStr];
        titleLb2.text = [NSString stringWithFormat:@"苏州高新区%@年%@月实事工程进度图表",yearStr,monthStr];
    }
    [self refreshDatasByIndex:1];
    
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


- (void)viewWillDisappear:(BOOL)animated{
    
    if (_urlConnHelper) {
        [_urlConnHelper cancel];
    }
    if (_datePopover) {
        [_datePopover dismissPopoverAnimated:YES];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_resultDic release];
    [_ZDXMchartView release];
    [_ZDXMitemAry release];
    [_SSGCchartView release];
    [_SSGCitemAry release];
    [_urlConnHelper release];
    [_dateSelectCtrl release];
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
