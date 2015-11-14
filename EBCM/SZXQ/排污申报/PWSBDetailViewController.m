//
//  PWSBDetailViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PWSBDetailViewController.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"
#import "ChildPWSBDetailViewController.h"

@interface PWSBDetailViewController ()
@property(nonatomic,assign) NSInteger dataType;
@property(nonatomic,retain) NSArray *aryYSBData;
@property(nonatomic,retain) NSArray *aryHDSData;
@property(nonatomic,retain) NSArray *aryJFSData;
@end

@implementation PWSBDetailViewController
@synthesize resTableView,dataType,wrybh,wrymc;
@synthesize aryHDSData,aryJFSData,aryYSBData,urlConnHelper,infoLabel,factID,isFromWry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)requestData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    if(dataType == 0){
        [params setObject:@"QUERY_PWSB_YSBORHDS_LIST" forKey:@"service"];
        [params setObject:@"YSB" forKey:@"q_TYPE"];
    }
    else if(dataType == 1){
        [params setObject:@"QUERY_PWSB_YSBORHDS_LIST" forKey:@"service"];
        [params setObject:@"HDS" forKey:@"q_TYPE"];
    }
    else {
        [params setObject:@"QUERY_PWSB_JF_DETAIL" forKey:@"service"];
    }
    if (isFromWry) {
        [params setObject:wrybh forKey:@"q_WRYBH"];
    }
    else {
        [params setObject:factID forKey:@"q_FACTID"];
    }
       
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
 
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

-(void)segctrlClicked:(id)sender{
    UISegmentedControl *segCtrl = (UISegmentedControl*)sender;
    dataType = segCtrl.selectedSegmentIndex;
    if(segCtrl.selectedSegmentIndex == 0){
        if(aryYSBData && [aryYSBData count] > 0){
             [self.resTableView reloadData];
            return;
        }
            
    }else if(segCtrl.selectedSegmentIndex == 1){
        if(aryHDSData && [aryHDSData count] > 0){
            [self.resTableView reloadData];
            return;
        }
    }
    else {
        if(aryJFSData && [aryJFSData count] > 0){
            [self.resTableView reloadData];
            return;
        }
    }
    
    [self requestData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    infoLabel.text = wrymc;
    self.title = wrymc;
    infoLabel.backgroundColor = [UIColor colorWithRed:(0x50/255.0f) green:(0x8d/255.0f) blue:(0xd0/255.0f) alpha:1.000f];
    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"  月申报  ", @"  核定情况  ",@"  缴费情况  ",nil]];
    
    segCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
    [segCtrl addTarget:self action:@selector(segctrlClicked:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segCtrl;
    segCtrl.selectedSegmentIndex = 0;
    [segCtrl release];
    
    [segCtrl setSelectedSegmentIndex:0];
    dataType = 0;
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.infoLabel = nil;
    self.resTableView = nil;
}

-(void)dealloc{
    [infoLabel release];
    [wrybh release];
    [wrymc release];
    [aryYSBData release];
    [aryHDSData release];
    [aryJFSData release];
    [urlConnHelper release];
    [resTableView release];
    [super dealloc];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                       withObject:(id)UIInterfaceOrientationLandscapeLeft];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    
    
    [super viewWillDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [resultJSON objectFromJSONString];
    [resultJSON release];
    NSArray *returnAry = nil;
    if(dic)
        returnAry = [dic objectForKey:@"result"];
    if (dic ==nil || returnAry == nil||[returnAry count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    if(dataType == 0)
        self.aryYSBData = returnAry;
    else if(dataType == 1)
        self.aryHDSData = returnAry;
    else 
        self.aryJFSData = returnAry;
    
    
    [resTableView reloadData];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(dataType == 0)
        return [aryYSBData count];
    else if(dataType == 1)
        return [aryHDSData count];
    else 
        return [aryJFSData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      
    UIView *view= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 55)];
    view.backgroundColor = [UIColor whiteColor];
    NSArray *aryTitles = nil;
    if(dataType == 0)
        aryTitles  = [NSArray arrayWithObjects: @"申报月份",@"废水排放量(吨)",@"废气排放量(立方米)",nil];
    else if(dataType == 1)
        aryTitles  = [NSArray arrayWithObjects: @"核定月份",@"废水排放量(吨)",@"废气排放量(立方米)",@"核定金额(元)",nil];
    else 
        aryTitles  = [NSArray arrayWithObjects:@"征收月份",@"废水排污费(元)",@"废气排污费(元)",@"噪声排污费(元)",@"固废排污费(元)",@"小型三产(元)",@"水超标排污费(元)	",@"危废排污费(元)",@"已缴金额(元)",@"未缴金额(元)",@"总排污费(元)",@"是否缴纳",nil];
    
    CGFloat width = 1024/([aryTitles count])-1;
    CGRect tRect = CGRectMake(0, 1, width, 54);
    
    for (int i =0; i < [aryTitles count]; i++) {
        UILabel *label =[[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor blackColor]];
        label.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        label.textAlignment = UITextAlignmentCenter;
        tRect.origin.x += width+1;
        label.numberOfLines = 2;
        
        if (i == [aryTitles count]-2)
            tRect.size.width = 1024.0 - tRect.origin.x;
   
        [label setText:[aryTitles objectAtIndex:i]];
        label.backgroundColor = [UIColor colorWithRed:(0x50/255.0f) green:(0x8d/255.0f) blue:(0xd0/255.0f) alpha:1.000f];
        [view addSubview:label];
        [label release];
    }
    
    return [view autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSUInteger row = [indexPath row];
    NSMutableArray *aryTmp = [NSMutableArray
                              arrayWithCapacity:10];
    
    NSMutableArray *aryTmp2 = [NSMutableArray arrayWithCapacity:10];
    if(dataType == 0){
        NSDictionary *dic = [aryYSBData objectAtIndex:row];
        NSString *strTmp = [dic objectForKey: @"DATA_MONTH"];
        NSString *strYearMonth = [NSString stringWithFormat:@"%@年%@月",[strTmp substringToIndex:4],[strTmp substringFromIndex:4]];
        [aryTmp addObject:strYearMonth];

        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"FSPFL"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"FQPFL"] intValue]]];

        aryTmp2 = [NSArray arrayWithObjects:@"0.33",@"0.33",@"0.33", nil];
        cell = [UITableViewCell makeMultiLabelsCell:tableView withTexts:aryTmp andWidths:aryTmp2 andHeight:45 andIdentifier:@"PWSBDetail0"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(dataType == 1){
        NSDictionary *dic = [aryHDSData objectAtIndex:row];
        NSString *strTmp = [dic objectForKey: @"DATA_MONTH"];
        NSString *strYearMonth = [NSString stringWithFormat:@"%@年%@月",[strTmp substringToIndex:4],[strTmp substringFromIndex:4]];
        [aryTmp addObject:strYearMonth];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"FSPFL"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"FQPFL"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"HDJE"] intValue]]];
         
        aryTmp2 = [NSArray arrayWithObjects:@"0.25",@"0.25",@"0.25",@"0.25",nil];
        cell = [UITableViewCell makeMultiLabelsCell:tableView withTexts:aryTmp andWidths:aryTmp2 andHeight:45 andIdentifier:@"PWSBDetail1"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    else {
        
        NSDictionary *dic = [aryJFSData objectAtIndex:row];
        NSString *strTmp = [dic objectForKey: @"MONEY_MONTHQUARTER"];
        NSString *strYearMonth = [NSString stringWithFormat:@"%@年%@月",[strTmp substringToIndex:4],[strTmp substringFromIndex:4]];
        [aryTmp addObject:strYearMonth];

        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY_WATER"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY_GAS"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY_SOUND"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY_SOLID"] intValue]]];
        
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY_MINI"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"OVER_MONEY"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"DANGER_MONEY"] intValue]]];
        
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"PAYMONEY"] intValue]]];
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY_OWE"] intValue]]];
        
        [aryTmp addObject:[NSString stringWithFormat:@"%d",[[dic objectForKey: @"MONEY"] intValue]]];
        if([[dic objectForKey: @"PAYFALG"] length] > 0)
            [aryTmp addObject:@"是"];
        else
            [aryTmp addObject:@"否"];
        for(int  i = 0; i <12; i++)
            [aryTmp2 addObject:[ NSString stringWithFormat:@"%f",1.0/12]];
        cell = [UITableViewCell makeMultiLabelsCell:tableView withTexts:aryTmp andWidths:aryTmp2 andHeight:45 andIdentifier:@"PWSBDetail2"];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(dataType == 2)return;
     ChildPWSBDetailViewController *infoController = [[ChildPWSBDetailViewController alloc] initWithNibName:@"ChildPWSBDetailViewController" bundle:nil];
     NSUInteger row = indexPath.row;
    infoController.dataType = dataType;
    if(dataType == 0){
        NSDictionary *dic = [aryYSBData objectAtIndex:row];
        infoController.monthYear = [dic objectForKey: @"DATA_MONTH"];
        infoController.wrybh =[dic objectForKey: @"FACT_ID"];
    }else if(dataType == 1){
        NSDictionary *dic = [aryHDSData objectAtIndex:row];
        infoController.monthYear = [dic objectForKey: @"DATA_MONTH"];
        infoController.wrybh =[dic objectForKey: @"FACT_ID"];

        
    }

        
    
    
    infoController.wrymc = wrymc;

     [self.navigationController pushViewController:infoController animated:YES];
     [infoController release];
}


@end
