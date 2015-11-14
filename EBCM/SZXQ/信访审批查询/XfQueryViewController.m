//
//  XfQueryViewController.m
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "XfQueryViewController.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "xfDetailsViewController.h"
#import "ServiceUrlString.h"

@implementation XfQueryViewController
@synthesize resultAry,urlConnHelper,currentTag,bHaveShow;
@synthesize datePopover,dateSelectCtrl,wrybh,wrymc;

#pragma mark - Private methods

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    btsrmcLbl.hidden = NO;
    btsrmc.hidden = NO;
    tsrxmLbl.hidden = NO;
    tsrxm.hidden = NO;
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
        [btsrmc resignFirstResponder];
        [tsrxm resignFirstResponder];
        
        bHaveShow = NO;
        CGRect origFrame = listTable.frame;
        aItem.title = @"开启查询";
        btsrmcLbl.hidden = YES;
        btsrmc.hidden = YES;
        tsrxmLbl.hidden = YES;
        tsrxm.hidden = YES;
        ksspsjLbl.hidden = YES;
        ksspsj.hidden = YES;
        jsspsjLbl.hidden = YES;
        jsspsj.hidden = YES;
        searchBtn.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:listTable];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-150, origFrame.size.width, origFrame.size.height+150);        
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
        listTable.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+150, origFrame.size.width, origFrame.size.height-150);
        
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

-(IBAction)searchButtonPressed:(id)sender
{
    NSString *tsrxmStr = tsrxm.text;
    NSString *btsrmcStr = btsrmc.text;
    NSString *ksspsjStr = ksspsj.text;
    NSString *jsspsjStr = jsspsj.text;
    
    if (tsrxmStr==nil) tsrxmStr = @"";
    if (btsrmcStr==nil) btsrmcStr = @"";
    if (ksspsjStr==nil) ksspsjStr = @"";
    if (jsspsjStr==nil) jsspsjStr = @"";
        
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WRY_LISTHJXF" forKey:@"service"];
    if ([btsrmcStr length] > 0)
        [params setObject:btsrmcStr forKey:@"wrymc"];
    if ([tsrxmStr length] > 0)
        [params setObject:tsrxmStr forKey:@"tsr"];
    if ([ksspsjStr length] > 0)
        [params setObject:ksspsjStr forKey:@"start_time"];
    if ([jsspsjStr length] > 0)
        [params setObject:jsspsjStr forKey:@"end_time"];
    
    NSString * urlString = [ServiceUrlString generateUrlByParameters:params];
     
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];  
    
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
    self.title = @"信访列表";
    
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    
    bHaveShow = YES;
    [self showSearchBar:item2];
    
    toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    
    [toolBar release];
    [item2 release];
    [flexItem release];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WRY_LISTHJXF" forKey:@"service"];
    if(wrybh && [wrybh length] >0){
        [params setObject:wrybh forKey:@"wrybh"];
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];  
    
    
    
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
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

-(void)dealloc
{
    
    [btsrmc release];;
    [tsrxm release];
    [ksspsj release];
    [jsspsj release];
    
    [btsrmcLbl release];
    [tsrxmLbl release];
    [ksspsjLbl release];
    [jsspsjLbl release];
    
    [searchBtn release];
    [listTable release];
    [resultAry release];
    
    [wrybh release];
    [wrymc release];
    [datePopover release];
    [dateSelectCtrl release];
    [super dealloc];
}

#pragma mark - URLConnHelper delegate

-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON =[[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
 //   resultJSON = [resultJSON stringByReplacingOccurrencesOfString:@"\r" withString:@""];
   // resultJSON = [resultJSON stringByReplacingOccurrencesOfString:@"\n" withString:@""];
   // resultJSON = [resultJSON stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSDictionary *dicData = [resultJSON objectFromJSONString];
    NSArray *tmpAry = [dicData objectForKey:@"data"];
    if (tmpAry == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有符合条件的数据" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    self.resultAry = tmpAry;
    
    [listTable reloadData];
    
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"查询结果"; 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [resultAry count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell release];
    }
    int row = indexPath.row;
    NSDictionary *dic = [resultAry objectAtIndex:row];
    NSString *dwmc = [NSString stringWithFormat:@"被投诉单位：%@",[dic objectForKey:@"BTSDWMC"]];
    NSString *dwbh = [dic objectForKey:@"BTSDWDZ"];
    NSString *cljg = [dic objectForKey:@"TSSJ"];
    NSString *lxdh = [dic objectForKey:@"TSR"];
    
    if ([cljg length] > 0)
        cljg = [NSString stringWithFormat:@"投诉时间：%@",[cljg substringToIndex:10]];
    else
        cljg = @"";
    
    if ([lxdh length] > 0)
        lxdh = [NSString stringWithFormat:@"投诉人：%@",lxdh];
    else
        lxdh = @"";
    
    if ([dwbh length] > 0)
        dwbh = [NSString stringWithFormat:@"被投诉单位地址：%@ \n是否调查：%@    调查时间：%@",dwbh,[dic objectForKey:@"SFCL"],[dic objectForKey:@"CLSJ"]];
    else
        dwbh = @"";
    
    cell = [UITableViewCell makeSubCell:tableView withTitle:dwmc SubValue1:dwbh SubValue2:lxdh SubValue3:cljg];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0&&indexPath.row!=[resultAry count])
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSDictionary *dic = [resultAry objectAtIndex:row];
    xfDetailsViewController *detailController = [[xfDetailsViewController alloc] initWithNibName:@"xfDetailsViewController" bundle:nil];
    detailController.wrybh = [dic objectForKey:@"BTSDWBH"];
    detailController.dwmc = [dic objectForKey:@"BTSDWMC"];
    detailController.xh = [dic objectForKey:@"XFBH"];
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];
 
}

@end
