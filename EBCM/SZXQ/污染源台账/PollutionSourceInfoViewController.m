//
//  PollutionSourceInfoViewController.m
//  EditingWord
//
//  Created by power humor on 12-6-26.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "PollutionSourceInfoViewController.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "ServiceUrlString.h"
#import "HtmlTableGenerator.h"
#import "ServiceType.h"
#import "PWSBDetailViewController.h"
#import "ModifyWryLocViewController.h"
#import "XmspQueryListViewController.h"
#import "XfQueryViewController.h"
#import "StandingBookListVC.h"
#import "WPDataViewController.h"
#import "SYXListVC.h"
#import "YSDetailVC.h"
#import "XKZListVC.h"
#import "XCQZDetailVC.h"
#import "XZCFListVC.h"
#import "QYDADetailVC.h"

@interface PollutionSourceInfoViewController ()
@property(nonatomic,retain) NSArray *aryCountKeys;
@end


@implementation PollutionSourceInfoViewController
@synthesize wrybh,wrymc,serviceType;
@synthesize webview,menuTableView;
@synthesize popController;
@synthesize urlConnHelper,wryInfoDic,aryMenus,aryCountKeys;

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


#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData{
    
    NSString *resultJSON =[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSString *htmlStr;
    if (curChooseTag==0) {
        NSArray *resultArr = [resultJSON objectFromJSONString];
        if(resultArr.count==0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"请求数据失败,请检查网络连接并重试。"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            [resultJSON release];
            return;
        }
        NSDictionary * dic = [resultArr objectAtIndex:0];
        self.wryInfoDic = dic;
        htmlStr = [HtmlTableGenerator genContentWithTitle:wrymc andParaMeters:wryInfoDic andType:serviceType];
        webview.dataDetectorTypes = UIDataDetectorTypeNone;
    }
    
    else{
        
        htmlStr = resultJSON;
    }
    
    [self.webview loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
    webview.dataDetectorTypes = UIDataDetectorTypeNone;
    [resultJSON release];
    
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
    return;
}

-(void)chooseInfoData:(id)sender
{
    [UIView animateWithDuration:0.2 animations:
     ^{
         if(menuTableView.frame.origin.x == 768){
             menuTableView.frame = CGRectMake(768-240, 0, 240, 960);
             [menuTableView reloadData];
         }else {
             menuTableView.frame = CGRectMake(768, 0, 240, 960);
         }

     }
     ];
       
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuTableView.frame = CGRectMake(768, 0, 240, 960);
    curChooseTag = 0;
    
    self.aryMenus = [NSArray arrayWithObjects:@"企业基本信息",@"项目审批情况",@"排污许可证情况",@"排污收费情况",@"现场执法情况",@"被投诉情况", nil];

    self.aryCountKeys = [NSArray arrayWithObjects:@"QUERY_WRY_INFO",@"QUERY_WRY_XMSP",
                        @"QUERY_WRY_PWXKZ",@"QUERY_WRY_PWSF",@"QUERY_WRY_XCZF",@"QUERY_WRY_HJXF",nil];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStyleDone target:self action:@selector(chooseInfoData:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    // Do any additional setup after loading the view from its nib.
    [self loadDataFromNetWorld];
}

- (void)loadDataFromNetWorld{
    
    self.title = [NSString stringWithFormat:@"%@-%@",wrymc,[self.aryMenus objectAtIndex:curChooseTag]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:[aryCountKeys objectAtIndex:curChooseTag] forKey:@"service"];
    [params setObject:wrybh forKey:@"wrybh"];
    if (curChooseTag==0) {
         [params setObject:@"json" forKey:@"dataType"];
    }
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

-(void)viewWillAppear:(BOOL)animated{
    menuTableView.frame = CGRectMake(768, 0, 240, 960);
    [super viewWillAppear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    [wrybh release];
    [wrymc release];
    [webview release];
    [wryInfoDic release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [aryMenus count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [aryMenus objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    curChooseTag = indexPath.row;
    self.serviceType = curChooseTag;
    [self loadDataFromNetWorld];
    [self chooseInfoData:nil];
    
}

@end
