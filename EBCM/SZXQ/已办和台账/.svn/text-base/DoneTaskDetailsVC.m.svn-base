//
//  DoneTaskDetailsVC.m
//  HNMobileLaw
//
//  Created by 王 哲义 on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DoneTaskDetailsVC.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"
#import "HtmlTableGenerator.h"

@implementation DoneTaskDetailsVC
//@synthesize xczfbh,myWeb,forthModel;
@synthesize xczfbh,myWeb;
@synthesize myTable,listTable,fileName;
@synthesize recordStatus,resultDic;
@synthesize webservice,urlString,currentBh;
@synthesize detailController,bDetailShow,mainDic,daweiMC,isXCJCBL;
@synthesize isBaseInfo;

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
        
        rect = CGRectMake(768, 0, 441, 960);
        
        CGRect rect2 = CGRectZero;
        rect2 = CGRectMake(768+131, 0, 310, 960);
        
        detailController.view.alpha = 0;
        detailController.view.frame = rect;
        
        listTable.alpha = 0;
        listTable.frame = rect2;
        
        [UIView commitAnimations];
    }
    
    else
    {
        [detailController.view removeFromSuperview];
        self.detailController  = nil;
    }
    
    bDetailShow = NO;
}

-(void)detailSwipeFromLeft
{
	if(detailController == nil || detailController.view.superview == nil)
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

-(void)showDetailController:(DoneRecordsListVC *)viewController animated:(BOOL)animated
{
	if(detailController && detailController.view.superview != nil)
	{
		[self hideDetailController:NO];
	}
    
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.detailController = nc;
    nc.delegate = self;
    [nc release];
    
    nc.view.frame = CGRectMake(768 - 441, 0, 441, 960);
    listTable.alpha = 1;
    listTable.frame = CGRectMake(768 - 260, 0, 310-50, 960);
    viewController.view.frame = CGRectMake(0, 0, nc.view.frame.size.width, nc.view.frame.size.height - 44);
	
    //添加手势 向右滑的手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeFromLeft)];
    swipeGesture.direction =  UISwipeGestureRecognizerDirectionRight;
    [detailController.view addGestureRecognizer:swipeGesture];
    [swipeGesture release];
	
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detailView_left_shadow.png"]];
    iv.frame = CGRectMake(-25, 0, 27, detailController.view.frame.size.height);
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
		[detailController.view.layer addAnimation:transition forKey:nil];
        [listTable.layer addAnimation:transition forKey:nil];
	}
	
	[self.view addSubview:nc.view];
    [self.view addSubview:listTable];
    
    bDetailShow = YES;
}


- (void)getWebData
{
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];
}

- (IBAction)selectRecordToRead:(id)sender
{
    if (bDetailShow)
        [self hideDetailController:YES];
    else
    {
        DoneRecordsListVC *childView = [[[DoneRecordsListVC alloc] initWithNibName:@"DoneRecordsListVC" bundle:nil] autorelease];
        childView.isBaseInfo = isBaseInfo;
        childView.xczfbh = xczfbh;
        if (!isBaseInfo) {
            childView.xcjcbl_count = [[mainDic objectForKey:@"XCJCBLCOUNT"] intValue];
            childView.xccyjl_count = [[mainDic objectForKey:@"XCCYJLCOUNT"] intValue];
            childView.xzcl_count = [[mainDic objectForKey:@"XZCLCOUNT"] intValue];
            childView.laspb_count = [[mainDic objectForKey:@"XZCFCOUNT"] intValue];
            childView.xwbl_count = [[mainDic objectForKey:@"XWBLCOUNT"] intValue];
            childView.fjgl_count = [[mainDic objectForKey:@"FJCOUNT"] intValue];
            childView.yjtzd_count = [[mainDic objectForKey:@"YJTZDCOUNT"] intValue];
            childView.xzjys_count = [[mainDic objectForKey:@"XZJYSCOUNT"] intValue];
            childView.xztss_count = [[mainDic objectForKey:@"XZTSSCOUNT"] intValue];
            childView.xzjss_count = [[mainDic objectForKey:@"XZJSSCOUNT"] intValue];
            childView.xzjcs_count = [[mainDic objectForKey:@"XZJCSCOUNT"] intValue];
            childView.cfajhfb_count = [[mainDic objectForKey:@"CFAJHFBCOUNT"] intValue];
            childView.xzjshfb_count = [[mainDic objectForKey:@"XZJSHFBCOUNT"] intValue];
            childView.hjjcyjs_count = [[mainDic objectForKey:@"HJJCYJSCOUNT"] intValue];
            childView.zdxmxzfds_count = [[mainDic objectForKey:@"ZDXMXZFDSCOUNT"] intValue];
            childView.gpdb_count = [[mainDic objectForKey:@"GPDBCOUNT"] intValue];
            childView.hjwfxwlaspb_count = [[mainDic objectForKey:@"WFLASPCOUNT"] intValue];
            childView.xzcfyjs_count = [[mainDic objectForKey:@"XZCFYJSCOUNT"] intValue];
        }
        else{
            childView.ztzg_count = [[mainDic objectForKey:@""] intValue];
            childView.swrfz_count = [[mainDic objectForKey:@""] intValue];
            childView.fqwrfz_count = [[mainDic objectForKey:@""] intValue];
            childView.wxpcfjgfwrfz_count = [[mainDic objectForKey:@""] intValue];
            childView.zswrfz_count = [[mainDic objectForKey:@""] intValue];
        }
       
        childView.delegate = self;
        childView.recordTable = listTable;
        [self showDetailController:childView animated:YES];
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

- (void)removeView:(UIView *)view
{
    [view removeFromSuperview];
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
    // Do any additional setup after loading the view from its nib.
    
    self.title = daweiMC;
    bDetailShow = NO;
    
    //列表初始化
    UITableView * table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 960) style:UITableViewStylePlain];
    self.myTable = table;
    [table release];
    //webView初始化
    UIWebView * Web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    self.myWeb = Web;
    myWeb.dataDetectorTypes = UIDataDetectorTypeNone;
    [Web release];
    
    
    NSMutableDictionary * param = [NSMutableDictionary dictionaryWithCapacity:10];
    if (self.isBaseInfo) {
        
        [param setObject:@"QUERY_XCZF_TZ_XCJCBL" forKey:@"service"];
        [param setObject:xczfbh forKey:@"XCZFBH"];
        [param setObject:@"json" forKey:@"dataType"];
    }
    else{
       
        [param setObject:@"QUERY_XCZF_TZ_BASE" forKey:@"service"];
        [param setObject:xczfbh forKey:@"XCZFBH"];
        [param setObject:@"json" forKey:@"dataType"];
    }
        
    self.urlString = [ServiceUrlString generateUrlByParameters:param];
    
    recordStatus = 0;
    
    [self getWebData];
    
    //笔录列表设置
    UITableView * listTab = [[UITableView alloc] initWithFrame:CGRectMake(768-310+50, 0, 310-50, 960) style:UITableViewStyleGrouped];
    self.listTable = listTab;
    [listTab release];
   
    UIImageView *listImage = [[UIImageView alloc] initWithFrame:CGRectMake(768-310+50, 0, 310-50, 960)];
    listImage.image = [UIImage imageNamed:@"f2f2f2(960).png"];
    listTable.backgroundView=listImage;
    [listImage release];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.delegate = nil;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [listTable.layer addAnimation:transition forKey:nil];
    
    //导航栏按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"查看其他笔录" style:UIBarButtonItemStyleDone target:self action:@selector(selectRecordToRead:)] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (webservice)
        [webservice cancel];
    
//    if (myWeb)
//        [myWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    [super viewWillDisappear:animated];
}


-(void)dealloc{
    [xczfbh release];
    [myWeb release];
    [myTable release];
    [listTable release];
    [fileName release];
    [resultDic release];
    [urlString release];
    [currentBh release];
    [detailController release];
    [mainDic release];
    [daweiMC release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData

{
    NSMutableString * receivedStr = [[[NSMutableString alloc] initWithData:webData encoding:NSUTF8StringEncoding] autorelease];
    
    NSArray * arr = [receivedStr objectFromJSONString];
    NSDictionary * receiveDic;
    if (arr.count>0) {
        receiveDic = [arr objectAtIndex:0];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示:" message:@"获取不到相关数据..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    self.mainDic = receiveDic;
    NSString *htmlStr = @"";
    
    if (isBaseInfo) {
        switch (recordStatus) {
            case 0:{
                //现场检查笔录
                /*
                NSMutableDictionary * curDic = [NSMutableDictionary dictionaryWithDictionary:receiveDic];
                
                //将检查开始时间转换为年月日时分秒字符串
                NSDictionary * timeDic = [curDic objectForKey:@"JCSJKS"];
                if (timeDic) {
                    NSString * KStimeStr = [self translateMSIntoDateTime:timeDic];
                    [curDic setValue:KStimeStr forKey:@"JCSJKS"];
                }
                //将检查结束时间转化为相应的格式
                NSDictionary * jsTimeDic = [curDic objectForKey:@"JCSJJS"];
                if (jsTimeDic) {
                    NSString * jsTimeStr = [self translateMSIntoDateTime:jsTimeDic];
                    [curDic setValue:jsTimeStr forKey:@"JCSJJS"];
                }
                //将签名时间转化为相应的年月日时分秒格式
                NSDictionary * QMdic = [curDic objectForKey:@"BDCRQMRQ"];
                if (QMdic) {
                    NSString * QMStr = [self translateMSIntoDateTime:QMdic];
                    [curDic setValue:QMStr forKey:@"BDCRQMRQ"];
                }
                
                //检查人签名日期
                NSDictionary * FZdic = [curDic objectForKey:@"ZFRYQMRQ"];
                if (FZdic) {
                    NSString * FZStr = [self translateMSIntoDateTime:FZdic];
                    [curDic setValue:FZStr forKey:@"ZFRYQMRQ"];
                }
                
                //其他参与人员签名日期
                NSDictionary * QTdic = [curDic objectForKey:@"QTCJRYQMRQ"];
                if (QTdic) {
                    NSString * QTStr = [self translateMSIntoDateTime:QTdic];
                    [curDic setValue:QTStr forKey:@"QTCJRYQMRQ"];
                }
                
                //创建时间
                NSDictionary * CJSJdic = [curDic objectForKey:@"CJSJ"];
                if (CJSJdic) {
                    NSString * CJSJstr = [self translateMSIntoDateTime:CJSJdic];
                    [curDic setValue:CJSJstr forKey:@"CJSJ"];
                }
                */
                 htmlStr = [HtmlTableGenerator genContentWithTitle:@"现场检查笔录" andParaMeters:receiveDic andType:13];
                
            }
                break;
            case 1:
                //总体状况
                break;
            case 2:
                //水污染防治
                break;
            case 3:
                //废气污染防治
                break;
            case 4:
                //危险品存放及固废污染防治
                break;
            case 5:
                //噪声污染防治
                break;
            default:
                break;
        }
    }
    else{
        
        switch (recordStatus) {
            case 0:{
                //调查基本信息
                if (receiveDic !=nil) {
                    htmlStr = [HtmlTableGenerator genContentWithTitle:@"调查基本信息" andParaMeters:receiveDic andType:11];
                }
            }
                break;
            case 1:{
                //现场采样纪录
            }
                break;
            case 2:{
                //行政处理
            }
                break;
            case 3:{
                //立案审批表
            }
                break;
            case 4:{
                //询问笔录
            }
                break;
            case 5:{
                //附件管理
            }
                break;
            case 6:{
                //约见通知单
            }
                break;
            case 7:{
                //行政建议书
            }
                break;
            case 8:{
                //行政提示书
            }
                break;
            case 9:{
                //行政警示书
            }
                break;
            case 10:{
                //行政纠错书
            }
                break;
            case 11:{
                //处理案件回访表
            }
                break;
            case 12:{
                //行政警示回访表
            }
                break;
            case 13:{
                //环境监察意见书
            }
                break;
            case 14:{
                //重点项目行政辅导书
            }
                break;
            case 15:{
                //挂牌督办
            }
                break;
            case 16:{
                //环境违法行为立案审批表
            }
                break;
            case 17:{
                //行政处罚意见书
            }
                break;
            default:
                break;
        }
    }
    myWeb.dataDetectorTypes = UIDataDetectorTypeNone;
    [myWeb loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
    if (myTable.superview != nil)
        [self removeView:myTable];
    if (myWeb.superview != nil)
        [self removeView:myWeb];
    
    [self addView:myWeb type:@"pageCurl" subType:kCATransitionFromRight];
    /*
    if (recordStatus == 5)
    {
        [myWeb setScalesPageToFit:YES];
        NSString* tmpDirectory  = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/"];
        NSString *tempFile = [tmpDirectory stringByAppendingPathComponent:fileName];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath: tempFile])
            [manager removeItemAtPath:tempFile error:NULL];
        
        NSURL *url = [NSURL fileURLWithPath:tempFile];
        [webData writeToURL:url atomically:NO];
        
        [myWeb loadRequest:[NSURLRequest requestWithURL:url]];
        
        if (myTable.superview != nil)
            [self removeView:myTable];
        if (myWeb.superview != nil)
            [self removeView:myWeb];
        
        [self addView:myWeb type:@"pageCurl" subType:kCATransitionFromRight];
        
        return;
    }
     */
}


#pragma mark - 将毫秒转化为年月日时分秒
-(NSString *)translateMSIntoDateTime:(NSDictionary *)dic{
    
    long long int time = [[dic objectForKey:@"time"] longLongValue];
    NSDate* date = [[[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0] autorelease];
    NSDateFormatter *dateFormatterjs = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatterjs.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *currentDateStr = [dateFormatterjs stringFromDate:date];
    return currentDateStr;
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

#pragma mark - Done Record delegate

- (void)returnRecordDictionary:(NSDictionary *)infoDic andStatus:(NSInteger)type
{
    if (infoDic==nil) {
        DoneTaskDetailsVC *childView = [[[DoneTaskDetailsVC alloc] initWithNibName:@"DoneTaskDetailsVC" bundle:nil] autorelease];
        childView.xczfbh = xczfbh;
        childView.isBaseInfo = YES;
        [self.navigationController pushViewController:childView animated:YES];
        return;
    }
    recordStatus = type;
    [self hideDetailController:YES];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:10];
    if (isBaseInfo) {
        switch (recordStatus) {
            case 0:
                //总体状况
                break;
            case 1:
                //水污染防治
                break;
            case 2:
                //废气污染防治
                break;
            case 3:
                //危险品存放及固废污染防治
                break;
            case 4:
                //噪声污染防治
                break;
            default:
                break;
        }
    }
    else{
        
        switch (recordStatus) {
            case 0:
                //调查基本信息
                [param setObject:@"QUERY_XCZF_TZ_BASE" forKey:@"service"];
                [param setObject:xczfbh forKey:@"XCZFBH"];
                [param setObject:@"json" forKey:@"dataType"];
                break;
            case 1:
                //现场采样纪录
                break;
            case 2:
                //行政处理
                break;
            case 3:
                //立案审批表
                break;
            case 4:
                //询问笔录
                break;
            case 5:
                //附件管理
                break;
            case 6:
                //约见通知单
                break;
            case 7:
                //行政建议书
                break;
            case 8:
                //行政提示书
                break;
            case 9:
                //行政警示书
                break;
            case 10:
                //行政纠错书
                break;
            case 11:
                //处理案件回访表
                break;
            case 12:
                //行政警示回访表
                break;
            case 13:
                //环境监察意见书
                break;
            case 14:
                //重点项目行政辅导书
                break;
            case 15:
                //挂牌督办
                break;
            case 16:
                //环境违法行为立案审批表
                break;
            case 17:
                //行政处罚意见书
                break;
            default:
                break;
        }
      
    }
    self.urlString = [ServiceUrlString generateUrlByParameters:param];
    NSLog(@"self.urlString------%@",self.urlString);
    [self getWebData];
}

@end
