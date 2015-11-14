//
//  AvailableDateListVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AvailableDateListVC.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"

@implementation AvailableDateListVC
@synthesize urlString,currentTag,bEmpty,nParseType;
@synthesize webservice,delegate,presentAry;
@synthesize wordsPopover,wordSelectCtrl,dateTable;

#pragma mark - Private methods

-(IBAction)cancelAvailableDate:(id)sender{
	
	[delegate returnAvailableDate:nil];
}


- (IBAction)selectWords:(id)sender
{
    if (wordsPopover)
        [wordsPopover dismissPopoverAnimated:YES];
    
    UITextField *fie = (UITextField *)sender;
    fie.text = @"";
    
    UIControl *btn = (UIControl *)sender;
    currentTag = btn.tag;
    
    switch (currentTag) {
        case 1:
        {
            NSMutableArray *yearAry = [NSMutableArray array];
            for (NSDictionary *tmpDic in _yearArr)
            {
                NSString *dateStr = [NSString stringWithFormat:@"%i",[[tmpDic objectForKey:@"validDate"] intValue]];
                [yearAry addObject:dateStr];
            }
            NSMutableArray *availableAry = [NSMutableArray arrayWithCapacity:10];
            for (NSString *tmpStr in yearAry)
            {
                if ([availableAry count] == 0)
                    [availableAry addObject:tmpStr];
                else
                {
                    BOOL bExist = NO;
                    for (NSString *avaiStr in availableAry)
                    {
                        if ([avaiStr isEqualToString:tmpStr])
                            bExist = YES;
                    }
                    if (!bExist)
                        [availableAry addObject:tmpStr];
                }
            }
            wordSelectCtrl.wordsAry = availableAry;
        }
            break;
            
        case 2:
        {
            if ([[yearField text] length] == 0 || [_yearArr count] == 0)
            {
                UIAlertView *alert = [[UIAlertView alloc] 
                                      initWithTitle:@"提示" 
                                      message:@"请先选择年份。" 
                                      delegate:nil
                                      cancelButtonTitle:@"确定" 
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                return;
            }
            
            NSMutableArray *monthAry = [NSMutableArray array];
            for (NSDictionary *tmpDic in _monthArr)
            {
                NSString *dateStr = [NSString stringWithFormat:@"%i",[[tmpDic objectForKey:@"validDate"] intValue]];
                [monthAry addObject:dateStr];
            }
            
            wordSelectCtrl.wordsAry = monthAry;
        }
            break;

        default:
            break;
    }
    
    [wordSelectCtrl.tableView reloadData];
    
    [wordsPopover presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - View lifecycle

- (id)initWithUrl:(NSString *)url andDelegate:(id)aDelegate andParseType:(NSInteger)type
{
    self = [super initWithNibName:@"AvailableDateListVC" bundle:nil];
    if (self) {
        self.urlString = url;
        self.delegate = aDelegate;
        nParseType = type;
        bEmpty = YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc{
    
    [_curDateArr release];
    [_yearArr release];
    [_monthArr release];
    [dateTable release];
    [presentAry release];
    [urlString release];
    delegate = nil;
    [wordsPopover release];
    [wordSelectCtrl release];
    [super dealloc];

 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"查找有效日期";
    self.contentSizeForViewInPopover = CGSizeMake(551, 651);
    self.presentAry = [NSMutableArray array];
    
    dateTable.delegate = self;
    dateTable.dataSource = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:(0xdb/255.0f) green:(0xdb/255.0f) blue:(0xd8/255.0f) alpha:(0xf2/255.0f)];
    
    //导航按钮设置
    UIBarButtonItem *aButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAvailableDate:)];
    
    self.navigationItem.leftBarButtonItem = aButtonItem;
	[aButtonItem release];
    
    //选择短语
    [yearField addTarget:self action:@selector(selectWords:) forControlEvents:UIControlEventTouchDown];
    [monthField addTarget:self action:@selector(selectWords:) forControlEvents:UIControlEventTouchDown];
    
    CommenWordsViewController *wordCtrl = [[CommenWordsViewController alloc] initWithStyle:UITableViewStylePlain];
    [wordCtrl setContentSizeForViewInPopover:CGSizeMake(200, 300)];
    self.wordSelectCtrl = wordCtrl;
    wordSelectCtrl.delegate = self;
    UIPopoverController *popCtrl2 = [[UIPopoverController alloc] initWithContentViewController:wordSelectCtrl];
    self.wordsPopover = popCtrl2;
    [wordCtrl release];
    [popCtrl2 release];
    
    //获取默认数据
    NSMutableString *strUrl = [NSMutableString stringWithString:urlString];
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self] autorelease];
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
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (webservice)
        [webservice cancel];
    if (wordsPopover)
        [wordsPopover dismissPopoverAnimated:YES];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


#pragma mark - Words delegate
- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row
{
  //  yearField.text = @"test";
    switch (currentTag) {
        case 1:
        {
            yearField.text = words;
            nParseType = 1;
            [self getDetailDateData];
        }
            break;
        
        case 2:
        {
            monthField.text = words;
            nParseType = 2;
            [self getDetailDateData];
        }
            break;
            
        default:
            break;
    }
    
    [wordsPopover dismissPopoverAnimated:YES];
}

#pragma mark - URLConnHelper delegate

-(void)processWebData:(NSData*)webData
{
    NSString *resultJSON = [[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] autorelease];
    
    if (nParseType==1) {
        self.yearArr = [resultJSON objectFromJSONString];
        if (_yearArr.count==0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"获取不到有效的年份。"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;

        }
        yearField.text = [NSString stringWithFormat:@"%i",[[[_yearArr objectAtIndex:0] objectForKey:@"validDate"] intValue]];
        [self getDetailDateData];
    }
    else if(nParseType==2){
        self.monthArr = [resultJSON objectFromJSONString];
        if (_monthArr.count==0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"查询不到数据。"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        monthField.text = [NSString stringWithFormat:@"%i",[[[_monthArr objectAtIndex:0] objectForKey:@"validDate"] intValue]];
        [self getDetailDateData];
    }
    else{
        
        NSArray * dayArr = [resultJSON objectFromJSONString];
        if (dayArr.count==0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"查询不到数据。"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            bEmpty = YES;
            return;
        }
        bEmpty = NO;
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary * dic in dayArr) {
            NSString * dayStr = [NSString stringWithFormat:@"%i",[[dic objectForKey:@"validDate"] intValue]];
            NSString * dateStr = [NSString stringWithFormat:@"%@-%@-%@",yearField.text,monthField.text,dayStr];
            [arr addObject:dateStr];
        }
        self.curDateArr = arr;
        [dateTable reloadData];
    }

}

-(void)getDetailDateData{
    
    
    NSMutableString * newUrlStr = [[NSMutableString alloc] initWithString:urlString];
    if (nParseType==1) {
        [newUrlStr appendFormat:@"&year=%@",yearField.text];
        nParseType = 2;
        
    }
    else if(nParseType==2){
        [newUrlStr appendFormat:@"&year=%@&month=%@",yearField.text,monthField.text];
        nParseType=3;
    }
    self.webservice = [[[NSURLConnHelper alloc] initWithUrl:newUrlStr andParentView:self.view delegate:self] autorelease];
    [newUrlStr release];
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
	return 56;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"有效日期列表";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    
    if (_curDateArr)
        if ([_curDateArr count] > 0)
            row = [_curDateArr count];
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"dateList_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier] autorelease];
    
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    if (bEmpty)
    {
        cell.textLabel.text = @"无数据";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.textLabel.text = [_curDateArr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (bEmpty) {
        return;
    }
    UITableViewCell *aCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *aStr = aCell.textLabel.text;
    if (![aStr isEqualToString:@"请在上方的输入框中输入查询条件"])
        [delegate returnAvailableDate:aStr];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

@end
