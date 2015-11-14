//
//  XmspQueryListViewController.m
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "XmspQueryListViewController.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "XmspDetailsViewController.h"
#import "ServiceUrlString.h"

@implementation XmspQueryListViewController
@synthesize resultAry,urlConnHelper,currentTag,bHaveShow;
@synthesize datePopover,dateSelectCtrl,wrybh,wrymc;

#pragma mark - Private methods

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    xmbhLbl.hidden = NO;
    xmbh.hidden = NO;
    xmmcLbl.hidden = NO;
    xmmc.hidden = NO;

    _haoLb.hidden = NO;
    _leftlb.hidden = NO;
    _yearF.hidden = NO;
    _rightlb.hidden = NO;
    _numF.hidden = NO;
    tzdwLbl.hidden = NO;
    tzdw.hidden = NO;
    ksspsjLbl.hidden = NO;
    ksspsj.hidden = NO;
    jsspsjLbl.hidden = NO;
    jsspsj.hidden = NO;
    
    searchBtn.hidden = NO;
}

- (void)showSearchBar:(id)sender {
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender; 
    if(bHaveShow)
    {
        [xmbh resignFirstResponder];
        [xmmc resignFirstResponder];
        [tzdw resignFirstResponder];
        [_numF resignFirstResponder];
        
        bHaveShow = NO;
        CGRect origFrame = listTable.frame;
        aItem.title = @"开启查询";
        
        _leftlb.hidden = YES;
        _haoLb.hidden = YES;
        _yearF.hidden = YES;
        _rightlb.hidden = YES;
        _numF.hidden = YES;
        xmbhLbl.hidden = YES;
        xmbh.hidden = YES;
        xmmcLbl.hidden = YES;
        xmmc.hidden = YES;
        tzdwLbl.hidden = YES;
        tzdw.hidden = YES;
        ksspsjLbl.hidden = YES;
        ksspsj.hidden = YES;
        jsspsjLbl.hidden = YES;
        jsspsj.hidden = YES;
        
        searchBtn.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:listTable];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-173, origFrame.size.width, origFrame.size.height+173);
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShow = YES;
        CGRect origFrame = listTable.frame;
        
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:listTable];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+173, origFrame.size.width, origFrame.size.height-173);
        
        [UIView commitAnimations];
        
    }
}

- (IBAction)selectDate:(id)sender
{
    if (datePopover)
        [datePopover dismissPopoverAnimated:YES];
    
    UITextField *fie = (UITextField *)sender;
    fie.text = @"";
    
    UIControl *btn = (UIControl *)sender;
    currentTag = btn.tag;
    [datePopover presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(IBAction)searchButtonPressed:(id)sender;
{
    NSString *xmbhStr = xmbh.text;
    NSString *xmmcStr = xmmc.text;
    NSString *tzdwStr = tzdw.text;
    NSString *ksspsjStr = ksspsj.text;
    NSString *jsspsjStr = jsspsj.text;
    NSString *yearStr = _yearF.text;
    NSString *numStr = _numF.text;
    if (xmbhStr==nil) xmbhStr = @"";
    if (xmmcStr==nil) xmmcStr = @"";
    if (tzdwStr==nil) tzdwStr = @"";
    if (ksspsjStr==nil) ksspsjStr = @"";
    if (jsspsjStr==nil) jsspsjStr = @"";
    if (numStr==nil) {
        numStr = @"";
    }
    if (yearStr==nil) {
        yearStr = @"";
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [params setObject:@"XMSP_DATA_LIST" forKey:@"service"];
    if ([xmbhStr length] > 0) {
        [params setObject:xmbhStr forKey:@"xmwh1"];
    }
    if (yearStr.length>0) {
        [params setObject:yearStr forKey:@"xmwh2"];
    }

    if (numStr.length>0) {
        [params setObject:numStr forKey:@"xmwh3"];
    }

    if ([xmmcStr length] > 0)
        [params setObject:xmmcStr forKey:@"xmmc"];
    
    if ([tzdwStr length] > 0)
        [params setObject:tzdwStr forKey:@"jsdw"];
    
    if ([ksspsjStr length] > 0)
        [params setObject:ksspsjStr forKey:@"spsj_start"];
    if ([jsspsjStr length] > 0)
        [params setObject:jsspsjStr forKey:@"spsj_end"];
    
    NSString *urlString = [ServiceUrlString generateUrlByParameters:params];
        
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];
    //苏
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
    self.title = @"项目审批列表";
    
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy"];
    NSDate *date = [NSDate date];
    curYearSelectTag = -1;
    NSString * dateStr = [formatter stringFromDate:date];
    yearsArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<20; i++) {
        int curYear = [dateStr intValue]-i;
        NSString * year = [NSString stringWithFormat:@"%i",curYear];
        [yearsArr addObject:year];
    }
    
    bHaveShow = YES;
    [self showSearchBar:item2];
    
    toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"XMSP_DATA_LIST" forKey:@"service"];
    
    if(wrybh && [wrybh length] > 0){
        [params setObject:wrybh forKey:@"wrybh"];
        self.navigationItem.rightBarButtonItem = nil;

    }
    NSString *urlString = [ServiceUrlString generateUrlByParameters:params];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];
    
    
    
    //选择时间
    [ksspsj addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    [jsspsj addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    
    PopupDateViewController *dateCtrl = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
    self.dateSelectCtrl = dateCtrl;
    dateSelectCtrl.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateSelectCtrl];
    UIPopoverController *popCtrl1 = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.datePopover = popCtrl1;
    [dateCtrl release];
    [nav release];
    [popCtrl1 release];
}

- (void)viewDidUnload
{
    [self setLeftlb:nil];
    [self setYearF:nil];
    [self setRightlb:nil];
    [self setNumF:nil];
    [self setHaoLb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (datePopover)
        [datePopover dismissPopoverAnimated:YES];
    if (urlConnHelper)
        [urlConnHelper cancel];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

-(void)dealloc{
    
    [yearsArr release];
    [popover release];
    [resultAry release];
    [_leftlb release];
    [_yearF release];
    [_rightlb release];
    [_numF release];
    [_haoLb release];
    [datePopover release];
    [dateSelectCtrl release];
    [xmbh release];
    [xmmc release];
    [tzdw release];
    [ksspsj release];
    [jsspsj release];
    [wrybh release];
    [wrymc release];
    [xmbhLbl release];
    [xmmcLbl release];
    [tzdwLbl release];
    [ksspsjLbl release];
    [jsspsjLbl release];
    [searchBtn release];
    [listTable release];
    [super dealloc];
    
}



#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    NSMutableString * receistr = [[NSMutableString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSDictionary *dicData = [receistr objectFromJSONString];
    self.resultAry = [dicData objectForKey:@"data"];
    if (resultAry.count==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"获取不到数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    [listTable reloadData];
    [receistr release];
    
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

#pragma mark - PopoverDate delegate

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date;
{
    if (bSaved) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        if ([dateString isEqualToString:@"2013-12-30"]) {
            dateString = @"2012-12-30";
        }
        else if([dateString isEqualToString:@"2013-12-31"]) {
            dateString = @"2012-12-31";
        }

        if (currentTag == 1)
            ksspsj.text = dateString;
        else
            jsspsj.text = dateString;
    }
    
    [datePopover dismissPopoverAnimated:YES];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"查询结果"; 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [resultAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    for (UIView *view in cell.subviews) {
        if (view.tag>10) {
            [view removeFromSuperview];
        }
    }
    cell.textLabel.font = [UIFont  systemFontOfSize:20.0];
    cell.detailTextLabel.font = [UIFont  systemFontOfSize:16.0];
    
    int row = indexPath.row;
    NSDictionary *dic = [resultAry objectAtIndex:row];
    NSString *xmmcStr = [NSString stringWithFormat:@"项目名称:%@",[dic objectForKey:@"XMMC"]];
    NSString * jsdwStrAndJsdd = [NSString stringWithFormat:@"建设单位:%@    建设地点:%@",[dic objectForKey:@"JSDW"],[dic objectForKey:@"LXDZ"]];
//    NSString *wrymcStr = [dic objectForKey:@"WRYMC"];
//    NSString *pfsjStr = [dic objectForKey:@"PFSJ"];
//    if ([pfsjStr length] > 0)
//        pfsjStr = [NSString stringWithFormat:@"批复时间:%@",[pfsjStr substringToIndex:10]];
//    else
//        pfsjStr = @"";
    cell.textLabel.text = xmmcStr;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@   %@",wrymcStr,pfsjStr];
    cell.detailTextLabel.text = jsdwStrAndJsdd;
    UILabel * shenpiLb = [[UILabel alloc] initWithFrame:CGRectMake(500.0, 35.0, 250.0, 20.0)];
    if ([[dic objectForKey:@"SFTGSP"] intValue]==1) {
        shenpiLb.text = @"通过";
        shenpiLb.textColor = [UIColor blueColor];
    }
    else{
        shenpiLb.text = @"未通过";
        shenpiLb.textColor = [UIColor redColor];
    }
    shenpiLb.tag = 11;
    shenpiLb.backgroundColor = [UIColor clearColor];
    shenpiLb.textAlignment = UITextAlignmentRight;
    shenpiLb.font = [UIFont systemFontOfSize:16.0];
    [cell addSubview:shenpiLb];
    [shenpiLb release];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSDictionary *dic = [resultAry objectAtIndex:row];
    XmspDetailsViewController *detailController = [[XmspDetailsViewController alloc] initWithNibName:@"XmspDetailsViewController" bundle:nil];
//    detailController.wrybh = [dic objectForKey:@"WRYBH"];
    detailController.xmbh = [dic objectForKey:@"XMBH"];
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];
    // Navigation logic may go here. Create and push another view controller.
}

- (IBAction)chooseXMYear:(id)sender {
    
    if (popover) {
        [popover dismissPopoverAnimated:YES];
    }
    
    _yearF.text = @"";
    PaiKouTableViewController *controller = [[PaiKouTableViewController alloc] initWithStyle:UITableViewStylePlain AndInfoArr:yearsArr AndCurSelect:curYearSelectTag];
    controller.delegage = self;
    controller.curWuRanType = 3;
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    [controller release];
    popover.contentSize = CGSizeMake(130, 300);
    popover.tint = FPPopoverLightGrayTint;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:_yearF];
}

#pragma mark - PaiKouTableViewController的delegate处理

-(void)didSelectPaiKou:(NSDictionary *)PaiKouDic AndCurSelect:(int)curtag{
    
    curYearSelectTag = curtag;
    [popover dismissPopoverAnimated:YES];
    [popover autorelease];
    _yearF.text = [yearsArr objectAtIndex:curtag];
}

@end
