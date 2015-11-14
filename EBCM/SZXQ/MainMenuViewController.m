//
//  MainMenuViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "BtnsViewController.h"
#import "MenuItem.h"
#import "SettingsInfo.h"
#import "AboutViewController.h"
#import "WryMapViewController.h"
#import "XmspQueryListViewController.h"
#import "XfQueryViewController.h"
#import "MonitorViewController.h"
#import "PWSBViewController.h"
#import "HandbookDocumentVC.h"
#import "SZMonitorViewController.h"
#import "TableStatisticsViewController.h"

#import "CustomMoviePlayerViewController.h"
@interface MainMenuViewController ()
@property(nonatomic,retain)NSArray *aryOfItemsAry;//存放每一页的菜单按钮数组

@end

@implementation MainMenuViewController
@synthesize pageControlIsChangingPage;
@synthesize viewControllers,scrollView,pageControl;
@synthesize aryOfItemsAry,arcMenu,loginPersonLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)startSyncTables{
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"主菜单";
    
    EPNameArr = [[NSArray alloc] initWithObjects:@"法律法规",@"环保标准",@"作业指导书",@"应急管理", nil];
    [self setupPage];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];	
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.scrollView = nil;
    self.pageControl = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}

-(void)openMovie:(id)sender

{
    NSString *path = [self shareFilePath:@"wang.mp4"];

    CustomMoviePlayerViewController *movieController = [[CustomMoviePlayerViewController alloc] init];
    movieController.movieURL = [NSURL fileURLWithPath: path];
    
    [self.navigationController pushViewController:movieController animated:YES];

    [movieController release]; 
    
}                                                                         


- (void)toggleFromByPage:(NSInteger) nPage ByIndex:(NSInteger) nIndex {
    
    
    MenuItem *aItem = [[aryOfItemsAry objectAtIndex:nPage] objectAtIndex:nIndex];

    if(![aItem.className isEqualToString:@""]){
        
        if ([aItem.className isEqualToString:@"PortalSite"]) {
            [self gotoSafari];
            return;
        }
        
        if ([aItem.className isEqualToString:@"playMovie"]) {
            [self openMovie:nil];
            return;
        }

        
        Class classType = NSClassFromString(aItem.className);
        UIViewController *controller = [[classType alloc] initWithNibName:aItem.className bundle:nil];
        if ([controller isKindOfClass:[HandbookDocumentVC class]]) {
             controller.title = [EPNameArr objectAtIndex:nIndex];
            ((HandbookDocumentVC *)controller).firstPageType = [NSNumber numberWithInt:nIndex];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            return;
        }
        if ([controller isKindOfClass:[SZMonitorViewController class]]) {
            if (nPage!=0) {
                ((SZMonitorViewController *)controller).type = nIndex -7;
                
            }
            else{
                
                ((SZMonitorViewController *)controller).type = nIndex+3-1;
                ((SZMonitorViewController *)controller).title = aItem.title;
            }
            
        }
        if ([controller isKindOfClass:[MonitorViewController class]]) {
            [(MonitorViewController *)controller getCurType:nIndex];
        }
      
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    
    
    
}

- (void)dealloc {
    
    [loginPersonLabel release];
    [EPNameArr release];
    [viewControllers release];
    [aryOfItemsAry release];
    [pageControl release];
    [scrollView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark The Guts

#define kNumberOfPages 4
-(void)initialDataModel{
    
    //按钮对应的名称
    
    NSArray * ary0 = [NSArray arrayWithObjects:@"数字环保介绍",@"工作任务",@"蓝藻预警",@"建设项目统计",@"排污收费",@"环境信访",@"排污许可证",@"全区放射源",@"固危废统计",@"监测站统计",@"移动执法统计",@"门户网站",nil];
    
    NSArray *ary1=[NSArray arrayWithObjects:@"污染源台账",@"项目审批查询", @"排污收费",@"环境信访查询",@"执法台账",@"一企一档",@"地图查询",nil];
    NSArray *ary2=[NSArray arrayWithObjects:@"废水污染源",@"重金属污染源",@"污水处理厂",@"废气污染源",@"油烟监控",@"放射源",@"固废系统",@"水质站",@"大气站",@"噪声监测",nil];
    NSArray *ary3=[NSArray arrayWithObjects:@"法律法规",@"环保标准",@"作业指导书",@"应急管理",nil];
    NSArray *aryBtnTiltle = [NSArray arrayWithObjects:ary0,ary1,ary2,ary3,nil];
    
    //按钮对应的key
    NSArray *aryKey0 = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    NSArray *aryKey1 = [NSArray arrayWithObjects:@"0x600407",@"0x600401",@"0x600414",
                        @"0x600406",@"0x600411",@"",@"",nil];
    NSArray *aryKey2 = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",nil];
    NSArray *aryKey3 = [NSArray arrayWithObjects:@"0x600705",@"",@"",@"",nil];
   
    NSArray *aryBtnKeys = [NSArray arrayWithObjects:aryKey0,aryKey1,aryKey2,aryKey3,nil];
    
    //在此处添加对应的viewcontroller名字

    NSArray *aryClass0 = [NSArray arrayWithObjects:@"playMovie",@"SZMonitorViewController",@"ChartAndTableViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"PortalSite", nil];
    NSArray *aryClass1 = [NSArray arrayWithObjects:@"PollutionSourceQyertViewController",@"XmspQueryListViewController",@"PWSFViewController",@"XfQueryViewController",@"StandingBookListVC",@"QYDAWryViewController",@"WryMapViewController",nil];

    NSArray *aryClass2 = [NSArray arrayWithObjects:@"MonitorViewController",@"MonitorViewController",@"MonitorViewController",@"MonitorViewController",@"MonitorViewController",@"MonitorViewController",@"MonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",@"SZMonitorViewController",nil];
    NSArray *aryClass3 = [NSArray arrayWithObjects:@"HandbookDocumentVC",@"HandbookDocumentVC",@"HandbookDocumentVC",@"HandbookDocumentVC",nil];

    NSArray *aryClassArys = [NSArray arrayWithObjects:aryClass0,aryClass1,aryClass2,aryClass3,nil];
    
     NSMutableArray *aryPage0MenuItems = [[[NSMutableArray alloc] initWithCapacity:18] autorelease];
    NSMutableArray *aryPage1MenuItems = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
     NSMutableArray *aryPage2MenuItems = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
     NSMutableArray *aryPage3MenuItems = [[[NSMutableArray alloc] initWithCapacity:8] autorelease];
    
    self.aryOfItemsAry = [NSArray arrayWithObjects:aryPage0MenuItems,aryPage1MenuItems,aryPage2MenuItems,aryPage3MenuItems,nil];
    
    SettingsInfo *settings = [SettingsInfo sharedInstance];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        NSArray *pageKeys = [aryBtnKeys objectAtIndex:i];
        int btnCounts = [pageKeys count];
        for(int j = 0; j < btnCounts; j++){
            NSString *aMenuKey = [pageKeys objectAtIndex:j];
            if (settings.enableFilterMenu){
            //还没确定对应的key 所以暂时不判断
             //   if ([usrInfo.aryMenus containsObject:aMenuKey] == NO)
             //       continue;
            }
             
            MenuItem *aItem = [[MenuItem alloc] init];
            aItem.title = [[aryBtnTiltle objectAtIndex:i] objectAtIndex:j];
            aItem.imgName = [NSString stringWithFormat:@"mc_%d_%d",i+1,j+1];
            aItem.key = aMenuKey;
            aItem.className = [[aryClassArys objectAtIndex:i] objectAtIndex:j];
            [[aryOfItemsAry objectAtIndex:i] addObject:aItem];
        }
    }
    
}

-(void)gotoSafari{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sndhb.gov.cn/"]];
}


- (void)setupPage
{
    [self initialDataModel];
    
    NSArray *pageTitles = [NSArray arrayWithObjects:@"领导决策",@"业务查询",@"生态环境在线监控",@"环保手册", nil];
    
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < kNumberOfPages; i++) {
		[controllers addObject:[NSNull null]];
	}
	self.viewControllers = controllers;
	[controllers release];
	
	scrollView.delegate = self;
	
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
    
    
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	scrollView.backgroundColor = [UIColor clearColor];
	
	CGFloat cx = 0;
	for (int i = 0; i < kNumberOfPages; i++) {		
		// replace the placeholder if necessary
		BtnsViewController *controller = [viewControllers objectAtIndex:i];
		if ((NSNull *)controller == [NSNull null]) {
            NSString *title = [pageTitles objectAtIndex:i];
            NSArray *aryItems = [aryOfItemsAry objectAtIndex:i];
			controller = [[BtnsViewController alloc] initWithPage:i 
                                                         andTitle:title
                                                      andMenuItemes:aryItems];
			controller.parent = self;
			[viewControllers replaceObjectAtIndex:i withObject:controller];
			[controller release];
		}
		
		// add the controller's view to the scroll view
		if (nil == controller.view.superview) {
			CGRect frame = scrollView.frame;
			frame.origin.x = frame.size.width * i;
			frame.origin.y = 0;
			//frame.size.height = frame.size.height + 20;
			controller.view.frame = frame;
			[scrollView addSubview:controller.view];
		}
		
		cx += scrollView.frame.size.width;
	}
	
	self.pageControl.numberOfPages = kNumberOfPages;
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}

#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
	
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender 
{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlIsChangingPage = YES;	
}


-(void)showArcMenu{
    
    [self.view addSubview:arcMenu];
    [UIView beginAnimations:@"showArcMenu" context:nil];
    arcMenu.frame = CGRectMake(527, 763, 241, 241);
    [UIView commitAnimations]; 
}

-(void)hideArcMenu{
    [self.view addSubview:arcMenu];
    [UIView beginAnimations:@"hideArcMenu" context:nil];
    arcMenu.frame = CGRectMake(768, 960, 241, 241);
    [UIView commitAnimations]; 
}


-(void)arcMenuBtnPressed:(id)sender{
    UIButton *btn = (UIButton*)sender;
    
    if(btn.tag == 1){//
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(btn.tag == 2){//数据同步
        
    }
    else if(btn.tag == 3){
        
    }
    else if(btn.tag == 4){
        AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];	

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        nav.modalPresentationStyle =  UIModalPresentationFormSheet;
        [self presentModalViewController:nav animated:YES];
        nav.view.superview.frame = CGRectMake(30, 100, 320, 480);
        nav.view.superview.center = self.view.center;
        [controller release];
        [nav release];
    }
    
    
    [self hideArcMenu];
}




-(IBAction)arcMenuPressed:(id)sender{
    if(arcMenu == nil){
        self.arcMenu = [[[UIArcMenu alloc] initWithFrame:CGRectMake(768, 960, 241, 241) andTarget:self andSelector:@selector(arcMenuBtnPressed:)] autorelease];
        UISwipeGestureRecognizer *swipegesture =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(arcMenuPressed:)];
    //    UITapGestureRecognizer *tapgesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(arcMenuPressed:)];
        
        [arcMenu addGestureRecognizer:swipegesture];
    //    [arcMenu addGestureRecognizer:tapgesture];
        [swipegesture release];
        
    }
    if( arcMenu.frame.origin.x == 527){
        [self hideArcMenu];
    }
    else {
        [self showArcMenu];
    }

    
}
-(NSString*)shareFilePath:(NSString*)filePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent: filePath];
    
}

@end
