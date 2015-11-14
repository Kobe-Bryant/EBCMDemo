//
//  DoneRecordsListVC.m
//  HNMobileLaw
//
//  Created by 王 哲义 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DoneRecordsListVC.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"
#import "DoneTaskDetailsVC.h"

@implementation DoneRecordsListVC
@synthesize delegate,xczfbh,recordTable;
@synthesize recordAry,urlStr,webservice,type;
@synthesize xcjcbl_count,xccyjl_count,xzcl_count,laspb_count,xwbl_count,fjgl_count,yjtzd_count,xzjys_count,xztss_count,xzjss_count,xzjcs_count,cfajhfb_count,xzjshfb_count,hjjcyjs_count,zdxmxzfds_count,gpdb_count,hjwfxwlaspb_count,xzcfyjs_count,select,isBaseInfo;
@synthesize ztzg_count,swrfz_count,fqwrfz_count,wxpcfjgfwrfz_count,zswrfz_count;

#define xcjcblType 1
#define xccyjlType 2
#define xzclType 3
#define laspbType 4
#define xwblType 5
#define fjglType 6
#define yjtzdType 7
#define xzjysType 8
#define xztssType 9
#define xzjssType 10
#define xzjcsType 11
#define cfajhfbType 12
#define xzjshfbType 13
#define hjjcyjsType 14
#define zdxmxzfdsType 15
#define gpdbType 16
#define hjwfxwlaspbType 17
#define xzcfyjsType 18
#define noneType 19

#pragma mark - Private methods

- (void)getWebData
{
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:recordTable delegate:self] autorelease];
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        type = noneType;
        self.recordAry = [NSMutableArray arrayWithCapacity:50];
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
    
    NSMutableArray * leftNameArr = [NSMutableArray arrayWithCapacity:0];
    if (isBaseInfo) {
       
        NSDictionary * dic0 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"总体状况",@"",[NSNumber numberWithInt:ztzg_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic0];
        
        NSDictionary * dic1 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"水污染防治",@"",[NSNumber numberWithInt:xcjcbl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic1];
        
        NSDictionary * dic2 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"废气污染防治",@"",[NSNumber numberWithInt:xccyjl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic2];
        
        NSDictionary * dic3 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"危险品存放及固废污染防治",@"", [NSNumber numberWithInt:xzcl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic3];
        
        NSDictionary * dic4 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"噪声污染防治",@"", [NSNumber numberWithInt:laspb_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic4];
    }
    else{
        NSDictionary * dic0 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"调查基本信息",@"QUERY_XCZF_TZ_BASE", nil] forKeys:[NSArray arrayWithObjects:@"name",@"key", nil]];
        [leftNameArr addObject:dic0];
        
        NSDictionary * dic1 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"现场检查笔录",@"QUERY_XCZF_TZ_XCJCBL",[NSNumber numberWithInt:xcjcbl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic1];
        
        NSDictionary * dic2 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"现场采样记录",@"QUERY_XCZF_TZ_XCCYJL",[NSNumber numberWithInt:xccyjl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic2];
        
        NSDictionary * dic3 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政处理",@"QUERY_XCZF_TZ_XZCL", [NSNumber numberWithInt:xzcl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic3];
        
        NSDictionary * dic4 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"立案审批表",@"QUERY_XCZF_TZ_XZCF", [NSNumber numberWithInt:laspb_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic4];
        
        NSDictionary * dic5 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"询问笔录",@"QUERY_XCZF_TZ_XWBL",[NSNumber numberWithInt:xwbl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic5];
        
        NSDictionary * dic6 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"附件管理",@"QUERY_XCZF_TZ_FJ",[NSNumber numberWithInt:fjgl_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic6];
        
        NSDictionary * dic7 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"约见通知单",@"QUERY_XCZF_TZ_YJTZD",[NSNumber numberWithInt:yjtzd_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic7];
        
        NSDictionary * dic8 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政建议书",@"QUERY_XCZF_TZ_XZJYS",[NSNumber numberWithInt:xzjys_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic8];
        
        NSDictionary * dic9 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政提示书",@"QUERY_XCZF_TZ_XZTSS",[NSNumber numberWithInt:xztss_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic9];
        
        NSDictionary * dic10 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政警示书",@"QUERY_XCZF_TZ_XZJSS",[NSNumber numberWithInt:xzjss_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic10];
        
        NSDictionary * dic11 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政纠错书",@"QUERY_XCZF_TZ_XZJCS",[NSNumber numberWithInt:xzjcs_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic11];
        
        NSDictionary * dic12 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"处罚案件回访表",@"QUERY_XCZF_TZ_CFAJHFB",[NSNumber numberWithInt:cfajhfb_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic12];
        
        NSDictionary * dic13 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政警示回访表",@"QUERY_XCZF_TZ_XZJSHFB",[NSNumber numberWithInt:xzjshfb_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic13];
        
        NSDictionary * dic14 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"环境监察意见书",@"QUERY_XCZF_TZ_HJJCYJS",[NSNumber numberWithInt:hjjcyjs_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic14];
        
        NSDictionary * dic15 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"重点项目行政辅导书",@"QUERY_XCZF_TZ_ZDXMXZFDS",[NSNumber numberWithInt:zdxmxzfds_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic15];
        
        NSDictionary * dic16 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"挂牌督办",@"QUERY_XCZF_TZ_GPDB",[NSNumber numberWithInt:gpdb_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic16];
        
        NSDictionary * dic17 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"环境违法行为立案审批表",@"QUERY_XCZF_TZ_WFLASP",[NSNumber numberWithInt:hjwfxwlaspb_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic17];
        
        NSDictionary * dic18 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"行政处罚意见书",@"QUERY_XCZF_TZ_XZCFYJS",[NSNumber numberWithInt:xzcfyjs_count],nil] forKeys:[NSArray arrayWithObjects:@"name",@"key",@"count", nil]];
        [leftNameArr addObject:dic18];
    }
    self.leftTableInfoArr = leftNameArr;
    
    UITableView * leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 441-260,960) style:UITableViewStyleGrouped];
    leftTable.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
    leftTable.showsVerticalScrollIndicator = NO;
    leftTable.delegate = self;
    leftTable.dataSource = self;
    leftTable.tag = 10;
    [self.view addSubview:leftTable];
    [leftTable release];
    
    self.view.backgroundColor = [UIColor colorWithRed:(0xdb/255.0f) green:(0xdb/255.0f) blue:(0xd8/255.0f) alpha:(0xf2/255.0f)];
    recordTable.delegate = self;
    recordTable.tag = 11;
    recordTable.dataSource = self;
    [recordTable reloadData];
}

- (void)dealloc
{
    [_leftTableInfoArr release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (webservice)
        [webservice cancel];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - URL connhelp delegate

-(void)processWebData:(NSData*)webData
{
    NSString *receivedStr =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    
    [recordAry removeAllObjects];
    
//    if (type == xcjcblType)
//    {
//        NSArray *receivedAry = [receivedStr objectFromJSONString];
//        [recordAry addObjectsFromArray:receivedAry];
//        
//        [recordTable reloadData];
//        
//        return;
//    }
//    
//    if (type == xccyjlType)
//    {
//        NSDictionary *receivedDic = [receivedStr objectFromJSONString];
//        NSArray *returnAry = [receivedDic objectForKey:@"data"];
//        [recordAry addObjectsFromArray:returnAry];
//        
//        [recordTable reloadData];
//        return;
//    }
//    
//    if (current_count > 1)
//    {
//        NSArray *receivedAry = [receivedStr objectFromJSONString];
//        [recordAry addObjectsFromArray:receivedAry];
//    }
//    else
//    {
//        NSDictionary *recordDic = [receivedStr objectFromJSONString];
//        [recordAry addObject:recordDic];
//    }
//    
//    [recordTable reloadData];
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

#pragma mark - UITableView data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (tableView.tag==10) {
        return 50;
    }
	return 72;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==10) {
        return _leftTableInfoArr.count;
    }
    else{
        
        NSInteger row = 0;
        
        if (type == noneType)
            row = 1;
        
        else if (recordAry)
            row = [recordAry count];
        
        else
            row = 1;
        
        return row;

    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
    if (tableView.tag!=10) {
        
        if (type == noneType)
        {
            if (select) {
                NSString *cellIndentifier = @"none_cell";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (cell == nil)
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier] autorelease];
                cell.textLabel.font = [UIFont systemFontOfSize:20];
                cell.textLabel.text = @"     没有该类型笔录";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            else{
                NSString *cellIndentifier = @"Defult_cell";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (cell == nil)
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier] autorelease];
                cell.textLabel.font = [UIFont systemFontOfSize:20];
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.textLabel.text = @"请点击左边的按钮进行选择";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
        }
        else
        {
            NSString *cellIndentifier = @"DoneRecordList_cell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil)
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier] autorelease];
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            cell.textLabel.numberOfLines = 0;
            cell.detailTextLabel.numberOfLines = 0;
            
            NSDictionary *tmpDic = [recordAry objectAtIndex:indexPath.row];
            
            switch (type) {
                case xcjcblType:
                {
                   
                }
                    break;
                case xccyjlType:
                {
                    
                }
                    break;
                    
                case xzclType:
                {
                   
                }
                    break;
                    
                case laspbType:
                {
                   
                }
                case xwblType:
                {
                    
                }
                case fjglType:
                {
                    
                }
                    
                case yjtzdType:
                {
                    
                }
                    
                case xzjysType:
                {
                    
                }
                    
                case xztssType:
                {
                    
                }
                    
                case xzjssType:
                {
                    
                }
                    
                case xzjcsType:
                {
                    
                }
                    
                case cfajhfbType:
                {
                    
                }
                    
                case xzjshfbType:
                {
                    
                }
                    
                case hjjcyjsType:
                {
                    
                }
                    
                case zdxmxzfdsType:
                {
                    
                }
                    
                case gpdbType:
                {
                    
                }
                    
                case hjwfxwlaspbType:
                {
                    
                }
                    
                case xzcfyjsType:
                {
                    
                }
                    break;
                default:
                    break;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }

    }
    else{
        NSString *cellIndentifier = @"cell";
       
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil)
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier] autorelease];
        if (indexPath.row==0) {
            
            if (isBaseInfo) {
                 cell.textLabel.text = [NSString stringWithFormat:@"%@[%i]",[[_leftTableInfoArr objectAtIndex:indexPath.row] objectForKey:@"name"],[[[_leftTableInfoArr objectAtIndex:indexPath.row] objectForKey:@"count"] intValue]];
            }
            else{
                 cell.textLabel.text = [[_leftTableInfoArr objectAtIndex:indexPath.row] objectForKey:@"name"];
            }
            
        }
        else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@[%i]",[[_leftTableInfoArr objectAtIndex:indexPath.row] objectForKey:@"name"],[[[_leftTableInfoArr objectAtIndex:indexPath.row] objectForKey:@"count"] intValue]];
        }
        //lineBreakMode
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
   
        return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 10) {
        NSDictionary * curInfo = [_leftTableInfoArr objectAtIndex:indexPath.row];
        if (isBaseInfo) {
            if ([[curInfo objectForKey:@"count"] intValue] ==0) {
                type = noneType;
                select = YES;
                [recordTable reloadData];
            }
            else if([[curInfo objectForKey:@"count"] intValue] ==1){
                //当数量为1的情况
            }
            else{
                //当数量大于1的情况
            }

        }
        else{
            if (indexPath.row==0) {
                
                NSDictionary *tmpDic = [_leftTableInfoArr objectAtIndex:indexPath.row];
                [delegate returnRecordDictionary:tmpDic andStatus:0];
                
            }//当选择为现场检查笔录时
            else if(indexPath.row==1){
                
                if ([[curInfo objectForKey:@"count"] intValue] ==0) {
                    type = noneType;
                    select = YES;
                    [recordTable reloadData];
                }
                else if([[curInfo objectForKey:@"count"] intValue] ==1){
                    //当数量为1的情况
                     [delegate returnRecordDictionary:nil andStatus:0];
                
                }
                else{
                    //当数量大于1的情况
                }
                
            }
            else{
                if ([[curInfo objectForKey:@"count"] intValue] ==0) {
                    type = noneType;
                    select = YES;
                    [recordTable reloadData];
                }
                else if([[curInfo objectForKey:@"count"] intValue] ==1){
                    //当数量为1的情况
                }
                else{
                    //当数量大于1的情况
                }
            }

        }
        
    }
    else{
        
        UITableViewCell *aCell = [tableView cellForRowAtIndexPath:indexPath];
        if ([aCell.textLabel.text isEqualToString:@"     没有该类型笔录"])
            return;
        if ([aCell.textLabel.text isEqualToString:@"请点击左边的按钮进行选择"])
            return;
        NSDictionary *tmpDic = [recordAry objectAtIndex:indexPath.row];
        [delegate returnRecordDictionary:tmpDic andStatus:type];
    }
    
}

@end
