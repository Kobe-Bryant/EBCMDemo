//
//  SZMonitorViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SZMonitorViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "SZDetailsViewController.h"
#import "TableStatisticsViewController.h"
#import "MBRWViewController.h"
@interface SZMonitorViewController ()

@end

@implementation SZMonitorViewController
@synthesize urlConnHelper,returnAry,type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)requestData{
   
    NSDate * seldate = [NSDate date];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:seldate];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WATER_STATION_LIST" forKey:@"service"];
    switch (type) {
        case WATERSTATION:
            [params setObject:@"WATER" forKey:@"type"];
            break;
        case AIRSTATION:
            [params setObject:@"AIR" forKey:@"type"];
            break;
        case NOISE:
            [params setObject:@"NOISE" forKey:@"type"];
        default:
            break;
    }
    [params setObject:dateString forKey:@"date"];
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (type>=3) {
        NSArray * ldjcArr = nil;
        switch (type) {
            case 3:
            {
                ldjcArr = [NSArray arrayWithObjects:@"全局工作任务",@"目标任务", nil];
            }
                break;
            case 4:
            {
                
//                ldjcArr = [NSArray arrayWithObjects:@"蓝藻日报",@" 蓝藻周报",@"蓝藻月报",@"蓝藻年报", nil];
                ldjcArr = [NSArray array];
            }
                break;
            case 5:
            {
                ldjcArr = [NSArray arrayWithObjects:@"建设项目审批统计",@"建设项目环保投资统计", nil];
            }
                break;
            case 6:
            {
               ldjcArr = [NSArray arrayWithObjects:@"排污收费统计",@"排污收费量统计", nil]; 
            }
                break;
            case 7:
            {
               
                ldjcArr = [NSArray arrayWithObjects:@"环境信访监察统计",@"环境信访按街道统计", nil];
            }
                break;
            case 8:
            {
                ldjcArr = [NSArray arrayWithObjects:@"全区排污许可证统计", nil];
            }
                break;
            case 9:
            {
                ldjcArr = [NSArray arrayWithObjects:@"全区放射源统计", nil];
            }
                break;
            case 10:
            {
                 ldjcArr = [NSArray arrayWithObjects:@"危废转移审批统计",@"电子废物拆解统计", nil];
            }
                break;
            case 11:
            {
                ldjcArr = [NSArray arrayWithObjects:@"监测站环评验收统计",@"监测站项目完成统计",@"监测性质统计", nil];
            }
                break;
            case 12:
            {
                ldjcArr = [NSArray arrayWithObjects:@"移动执法统计",@"个人执法统计",@"按街道执法统计", nil];
            }
                break;
                
            default:
                break;
        }
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 960.0)];
        scroll.contentSize = CGSizeMake(768.0,60.0+(ldjcArr.count%4)==0?ldjcArr.count/4:(ldjcArr.count/4+1));
        [self.view addSubview:scroll];
        [scroll release];
        
        for (int i=0; i<ldjcArr.count; i++) {
            
            float butX = 66.5+(110+65)*(i%4);
            float butY = 60.0 +(110+70)*(i/4);
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(butX, butY, 110.0, 110.0);
            NSString * butImageName = [NSString stringWithFormat:@"mc_1_%i_%i.png",type-2,i];
            [but setImage:[UIImage imageNamed:butImageName] forState:0];
            [but setTitle:[ldjcArr objectAtIndex:i] forState:0];
            but.tag = i;
            [but addTarget:self action:@selector(clickOnBut:) forControlEvents:UIControlEventTouchUpInside];
            [scroll addSubview:but];
            
            float lbX = 34+175*(i%4);
            float lbY = 170+(30+20+110+20)*(i/4);
            UILabel * stationNameLb = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, 175.0, 30.0)];
            stationNameLb.text = [ldjcArr objectAtIndex:i];
            stationNameLb.backgroundColor = [UIColor clearColor];
            stationNameLb.textAlignment = UITextAlignmentCenter;
            [scroll addSubview:stationNameLb];
            [stationNameLb release];
        }
        return;

    }

    switch (type) {
        case WATERSTATION:
            self.title = @"水质自动监测站点";
            break;
        case AIRSTATION:
            self.title = @"大气自动监测站点";
            break;
        case NOISE:
            self.title = @"噪声自动监测";
        default:
            break;
    }
    
    [self requestData];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSString * receiveStr = [[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] autorelease];
    self.returnAry = [receiveStr objectFromJSONString];
    if (returnAry.count==0) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"获取不到数据!"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    [self initScrollView];
    
}

-(void)initScrollView{
    
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 960.0)];
    scroll.contentSize = CGSizeMake(768.0,60.0+(returnAry.count%4)==0?returnAry.count/4:(returnAry.count/4+1));
    [self.view addSubview:scroll];
    [scroll release];
    
    for (int i=0; i<returnAry.count; i++) {
        
        float butX = 66.5+(110+65)*(i%4);
        float butY = 60.0 +(110+70)*(i/4);
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(butX, butY, 110.0, 110.0);
        NSString * butImageName = [NSString stringWithFormat:@"mc_3_%i.png",8+type];
        [but setBackgroundImage:[UIImage imageNamed:butImageName] forState:0];
        but.tag = i;
        [but addTarget:self action:@selector(clickOnBut:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:but];
        
        float lbX = 34+175*(i%4);
        float lbY = 170+(30+20+110+20)*(i/4);
        UILabel * stationNameLb = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, 175.0, 30.0)];
        stationNameLb.text = [[returnAry objectAtIndex:i] objectForKey:@"站点名称"];
        stationNameLb.backgroundColor = [UIColor clearColor];
        stationNameLb.textAlignment = UITextAlignmentCenter;
        [scroll addSubview:stationNameLb];
        [stationNameLb release];
    }
}

-(void)clickOnBut:(UIButton *)sender{
    
    
    if (type>=3) {
        if (type==3&&sender.tag==1)
        {
            //目标任务
            MBRWViewController * mbrw = [[MBRWViewController alloc] initWithNibName:@"MBRWViewController" bundle:nil];
             [self.navigationController pushViewController:mbrw animated:YES];
            [mbrw release];
            return;
        }
        TableStatisticsViewController * table = [[TableStatisticsViewController alloc] initWithNibName:@"TableStatisticsViewController" bundle:nil];
        table.page = type-3;
        table.title = sender.titleLabel.text;
        table.aIndex = sender.tag;
        [self.navigationController pushViewController:table animated:YES];
        [table release];
        return;
    }
    
    int curTag = sender.tag;
    NSDictionary * dic = [returnAry objectAtIndex:curTag];
    SZDetailsViewController *infoController = [[SZDetailsViewController alloc] initWithNibName:@"SZDetailsViewController" bundle:nil];
    infoController.pointCode = [dic objectForKey:@"站点ID"];
    infoController.pointName = [dic objectForKey:@"站点名称"];
    switch (type) {
        case WATERSTATION:
            infoController.curType = @"WATER";
            break;
        case AIRSTATION:
            infoController.curType = @"AIR";
            break;
        case NOISE:
            infoController.curType = @"NOISE";
        default:
            break;
    }

    [self.navigationController pushViewController:infoController animated:YES];
    [infoController release];

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



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    
    
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    
    [returnAry release];
    [urlConnHelper release];
    [super dealloc];
}
/*
#pragma mark - tableview dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.returnAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *identifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
  
    NSDictionary *dic = [returnAry objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"监测点名称"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"监测时间：%@",[dic objectForKey:@"监测时间"]];


    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    SZDetailsViewController *infoController = [[SZDetailsViewController alloc] initWithNibName:@"SZDetailsViewController" bundle:nil];
    NSUInteger row = indexPath.row;
    NSDictionary *dicBH = [returnAry objectAtIndex:row];
    infoController.pointCode = [dicBH objectForKey:@"portId"];
    infoController.pointName = [dicBH objectForKey:@"监测点名称"];
    [self.navigationController pushViewController:infoController animated:YES];
    [infoController release];
    
}
*/
@end
