//
//  PWSBDetailViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChildPWSBDetailViewController.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"


@interface ChildPWSBDetailViewController ()
@property(nonatomic,assign) NSInteger showOutType;//显示哪一排口类型的数据

@end

@implementation ChildPWSBDetailViewController
@synthesize leftTableView,rightTableView, dataType,wrybh,wrymc;
@synthesize dicData,monthYear,urlConnHelper,aryOutName,showOutType,isFromWry;

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
        [params setObject:@"QUERY_PWSB_YSB_DETAIL" forKey:@"service"];
    }
    else if(dataType == 1){
        [params setObject:@"QUERY_PWSB_HDS_DETAIL" forKey:@"service"];
        
    }
    [params setObject:wrybh forKey:@"q_WRYBH"];
    [params setObject:monthYear forKey:@"q_DATAMONTH"];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    showOutType = 0;
    if(dataType == 0){
        self.title = [NSString stringWithFormat:@"%@(%@月申报)",wrymc,monthYear];
    }else {
        self.title = [NSString stringWithFormat:@"%@(%@核定数)",wrymc,monthYear];
    }
    
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.leftTableView = nil;
    self.rightTableView = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    
    
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    [leftTableView release];
    [wrybh release];
    [wrymc release];
    [rightTableView release];
    [monthYear release];
    [dicData release];
    [urlConnHelper release];
    [aryOutName release];

    [super dealloc];
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

    self.dicData = [NSMutableDictionary dictionaryWithCapacity:10];
    for(NSDictionary *dicTmp in returnAry){
        NSString *str = [dicTmp objectForKey:@"OUT_NAME"];
        if([str isEqualToString:@""] ||[str isEqualToString:@"4"])
            str = @"固废";
        
        NSMutableArray *aryItems = [dicData objectForKey:str];
        if(aryItems == nil){
            aryItems = [NSMutableArray arrayWithCapacity:100];
            [dicData setObject:aryItems forKey:str];
        }
        [aryItems addObject:dicTmp];
        
    }
    self.aryOutName = [dicData allKeys];

        
    
    [leftTableView reloadData];
    [rightTableView reloadData];
    
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
    if(leftTableView == tableView)
        return [aryOutName count];
    else {
        return [[dicData objectForKey:[aryOutName objectAtIndex:showOutType]] count];
    }
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    if(tableView == leftTableView)
    {
        height = 45;
    }
    else
    {
        height = 75;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view= nil;
    CGFloat width;
    NSArray *aryTitles = nil;
    if(tableView == leftTableView){
        
        aryTitles  = [NSArray arrayWithObjects: @"排放口名称",@"总排放量(千克)",nil];
        width = 254/([aryTitles count]);
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 254, 45)];
        
        CGRect tRect = CGRectMake(0, 0, width, 45);
        
        for (int i =0; i < [aryTitles count]; i++) {
            tRect.size.width = width;
            UILabel *label =[[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor darkGrayColor]];
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = UITextAlignmentCenter;
            tRect.origin.x += width+1;
            
            if (i == [aryTitles count]-2)
                tRect.size.width = 254.0-tRect.origin.x;
            
            label.numberOfLines = 0;
            label.backgroundColor = [UIColor clearColor];
            [label setText:[aryTitles objectAtIndex:i]];
            
            [view addSubview:label];
            [label release];
        }
        
    }else {
        
        if(dataType == 0)
            aryTitles  = [NSArray arrayWithObjects: @"排放口名称",@"污染物名称",@"污染物排放浓度(mg/L)",@"污染物排放标准(mg/L)",@"污染物排放量(千克)",nil];
        else if(dataType == 1)
            aryTitles  = [NSArray arrayWithObjects: @"排放口名称",@"污染物名称",@"污染物排放浓度(mg/L)",@"污染物排放标准(mg/L)",@"污染物排放量(千克)",@"污染物当量数",@"单价(元)",@"核定金额(元)",nil];
        width = 750.0/([aryTitles count])-1;
        view = [[UIView alloc] initWithFrame:CGRectMake(274, 0, 750, 75)];
        
        CGRect tRect = CGRectMake(0, 0, width, 75);
        
        for (int i =0; i < [aryTitles count]; i++) {
            UILabel *label =[[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [label setBackgroundColor:[UIColor colorWithRed:(0x50/255.0f) green:(0x8d/255.0f) blue:(0xd0/255.0f) alpha:1.000f]];
            [label setTextColor:[UIColor blackColor]];
            label.font = [UIFont fontWithName:@"Helvetica" size:17.0];
            label.textAlignment = UITextAlignmentCenter;
            tRect.origin.x += width+1;
            
            if (i == [aryTitles count]-2)
                tRect.size.width = 750.0-tRect.origin.x;
            
            label.numberOfLines = 0;
            [label setText:[aryTitles objectAtIndex:i]];
            
            [view addSubview:label];
            [label release];
        }
        view.backgroundColor = [UIColor whiteColor];
    }
    
    
    return [view autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSUInteger row = [indexPath row];

    if(leftTableView == tableView){
        //@"DATA_VALUE",
        static NSString *cellIdetify = @"ChildPwsbDetail2";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
        UILabel *label[6];
        CGFloat width = 254.0/2;
        if(!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify] autorelease];
            
            for (int i = 0; i< 2; i++) {
                label[i] = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 2, 80, 48)];
                label[i].backgroundColor = [UIColor clearColor];
                label[i].textColor = [UIColor blackColor];
                label[i].textAlignment = UITextAlignmentCenter;
                label[i].tag = 100+i;
                label[i].numberOfLines = 2;
                [cell.contentView addSubview:label[i]];
            }
        }
        
        NSArray *aryTmp = [dicData objectForKey:[aryOutName objectAtIndex:row]];
        NSDictionary *dic = [aryTmp objectAtIndex:0];
        label[0] = (UILabel *)[cell.contentView viewWithTag:100];
        label[0].text =  [aryOutName objectAtIndex:row];
        label[1] = (UILabel *)[cell.contentView viewWithTag:101];
        label[1].text =  [NSString stringWithFormat:@"%d",[[dic objectForKey:@"DATA_VALUE"] intValue]];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else {
        if(dataType == 0){

            static NSString *cellIdetify = @"ChildPwsbDetail0";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
            UILabel *label[6];
            CGFloat width = 750.0/5;
            if(!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify] autorelease];
                
                for (int i = 0; i< 5; i++) {
                    label[i] = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 2, width, 48)];
                    label[i].backgroundColor = [UIColor clearColor];
                    label[i].textColor = [UIColor blackColor];
                    label[i].textAlignment = UITextAlignmentCenter;
                    label[i].tag = 100+i;
                    label[i].numberOfLines =2;
                    [cell.contentView addSubview:label[i]];
                }
            }
            
            NSArray *aryTmp = [dicData objectForKey:[aryOutName objectAtIndex:showOutType]];
            NSDictionary *dic = [aryTmp objectAtIndex:row];
            label[0] = (UILabel *)[cell.contentView viewWithTag:100];
            label[0].text =  [aryOutName objectAtIndex:showOutType];
            label[1] = (UILabel *)[cell.contentView viewWithTag:101];
            label[1].text =  [dic objectForKey:@"NAME"];
            label[2] = (UILabel *)[cell.contentView viewWithTag:102];
            label[2].text =  [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"DENSITY"] floatValue]];
            label[3] = (UILabel *)[cell.contentView viewWithTag:103];
            label[3].text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"STANDARD_VALUE"] intValue]]; 
            label[4] = (UILabel *)[cell.contentView viewWithTag:104];
            label[4].text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"POLLUTION_VALUE"] intValue]];  
        }
        else if(dataType == 1){
            static NSString *cellIdetify = @"ChildPwsbDetail1";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
            UILabel *label[8];
            CGFloat width = 750.0/8;
            if(!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify] autorelease];
                
                for (int i = 0; i< 8; i++) {
                    label[i] = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 2, width, 48)];
                    label[i].backgroundColor = [UIColor clearColor];
                    label[i].textColor = [UIColor blackColor];
                    label[i].textAlignment = UITextAlignmentCenter;
                    label[i].tag = 100+i;
                    label[i].numberOfLines = 2;
                    [cell.contentView addSubview:label[i]];
                }
            }
            
            NSArray *aryTmp = [dicData objectForKey:[aryOutName objectAtIndex:showOutType]];
            NSDictionary *dic = [aryTmp objectAtIndex:row];
            label[0] = (UILabel *)[cell.contentView viewWithTag:100];
            label[0].text = [aryOutName objectAtIndex:showOutType];
            label[1] = (UILabel *)[cell.contentView viewWithTag:101];
            label[1].text =  [dic objectForKey:@"NAME"];
            label[2] = (UILabel *)[cell.contentView viewWithTag:102];
            label[2].text =  [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"DENSITY"] floatValue]]; 
            label[3] = (UILabel *)[cell.contentView viewWithTag:103];
            label[3].text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"STANDARD_VALUE"] intValue]]; 
            label[4] = (UILabel *)[cell.contentView viewWithTag:104];
            label[4].text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"POLLUTION_VALUE"] intValue]];
            label[5] = (UILabel *)[cell.contentView viewWithTag:105];
            label[5].text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"POLLUTION_EW"] intValue]]; 
            label[6] = (UILabel *)[cell.contentView viewWithTag:106];
            label[6].text =  [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"UNITPRICE"] floatValue]];  
            label[7] = (UILabel *)[cell.contentView viewWithTag:107];
            label[7].text =  [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"POLLUTION_MONEY"] floatValue]]; 
            
        }
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
    if(tableView == leftTableView)
        showOutType = indexPath.row;
    [self.rightTableView reloadData];
}


@end
