//
//  PollutionSourceQyertViewController.m
//  EditingWord
//
//  Created by power humor on 12-6-25.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "PollutionSourceQyertViewController.h"
#import "JSONKit.h"
#import "UITableViewCell+Custom.h"
#import "PollutionSourceInfoViewController.h"
#import "ServiceUrlString.h"
#import "ServiceType.h"
#import "ZrsUtil.h"
#import "QYDADetailVC.h"

@implementation PollutionSourceQyertViewController
@synthesize urlConnHelper,currentTag;
@synthesize returnAry,wordsPopover,wordSelectCtrl;
@synthesize WRYDZ,WRYMC,JGJB;
@synthesize wrydzLbl,wrymcLbl,jgjbLbl;
@synthesize searchBtn,myTableView,bHaveShow;
@synthesize levelCodeAry,jgjbValue,mainArray,subArray,childtype;

#pragma mark - Private methods

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{

    wrydzLbl.hidden = NO;
    WRYDZ.hidden = NO;
    wrymcLbl.hidden = NO;
    WRYMC.hidden = NO;

    jgjbLbl.hidden = NO;
    JGJB.hidden = NO;
    
    searchBtn.hidden = NO;
}

- (void)showSearchBar:(id)sender {
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender; 
    if(bHaveShow)
    {
        [WRYMC resignFirstResponder];
        [WRYDZ resignFirstResponder];

        
        bHaveShow = NO;
        CGRect origFrame = myTableView.frame;
        aItem.title = @"开启查询";
        wrydzLbl.hidden = YES;
        WRYDZ.hidden = YES;
        wrymcLbl.hidden = YES;
        WRYMC.hidden = YES;

        jgjbLbl.hidden = YES;
        JGJB.hidden = YES;
        
        searchBtn.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:myTableView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        myTableView.frame = CGRectMake(0, 0, origFrame.size.width, 960);
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShow = YES;
        CGRect origFrame = myTableView.frame;
        
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:myTableView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        myTableView.frame = CGRectMake(0, 120, origFrame.size.width, 960-120);
        
        [UIView commitAnimations];
        
    }
}

-(IBAction)searchWry:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    if(childtype == KChildQYDA){
        [params setObject:@"QUERY_YQYD_LIST" forKey:@"service"];

    }
    else{
        [params setObject:@"QUERY_WRY_LIST" forKey:@"service"];

    }
    [params setObject:WRYMC.text forKey:@"wrymc"];
    [params setObject:WRYDZ.text forKey:@"dwdz"];
    
    [params setObject:jgjbValue forKey:@"jgjb"];


    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
  
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease]; 
   
}

- (IBAction)selectWord:(id)sender
{
    if (wordsPopover)
        [wordsPopover dismissPopoverAnimated:YES];
    
    UITextField *field = (UITextField *)sender;
    field.text = @"";
    currentTag = field.tag;
    
    switch (currentTag) {
        case 3:
            self.jgjbValue = @"";
            wordSelectCtrl.wordsAry = [NSArray arrayWithObjects:@"国控",@"省控",@"市控",@"区控",@"非控", nil];
            break;
        
            
        default:
            break;
    }
    
    [wordSelectCtrl.tableView reloadData];
    
    [wordsPopover presentPopoverFromRect:[field bounds] inView:field permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
        self.levelCodeAry = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"9", nil];
        self.jgjbValue = @"";
        
        
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
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    if(childtype == KChildQYDA){
    
         [params setObject:@"QUERY_YQYD_LIST" forKey:@"service"];
        [params setObject:@"json" forKey:@"dataType"];
         self.title = @"一企一档查询";
    }
    else{
         [params setObject:@"QUERY_WRY_LIST" forKey:@"service"];
        self.title = @"污染源查询";
    }
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];   
    
    //读取行政区划代码文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xzqh" ofType:@"plist"];
    NSDictionary *tmpDic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.mainArray = [tmpDic objectForKey:@"XZQHArray"];
    
    //选择短语初始化
    CommenWordsViewController *wordCtrl = [[CommenWordsViewController alloc] initWithStyle:UITableViewStylePlain];
    [wordCtrl setContentSizeForViewInPopover:CGSizeMake(320, 400)];
    self.wordSelectCtrl = wordCtrl;
    wordSelectCtrl.delegate = self;
    UIPopoverController *popCtrl2 = [[UIPopoverController alloc] initWithContentViewController:wordSelectCtrl];
    self.wordsPopover = popCtrl2;
    [wordCtrl release];
    [popCtrl2 release];
    
    [JGJB addTarget:self action:@selector(selectWord:) forControlEvents:UIControlEventTouchDown];
    
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    
    bHaveShow = YES;
    [self showSearchBar:item2];
    
    toolBar.items = [NSArray arrayWithObjects: item2,flexItem,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    [item2 release];
    [flexItem release];
    [toolBar release];
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
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (wordsPopover)
        [wordsPopover dismissPopoverAnimated:YES];
    if (urlConnHelper)
        [urlConnHelper cancel];
    
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    [returnAry release];
    [super dealloc];
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    
    NSString *resultJSON =[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dicData = [resultJSON objectFromJSONString];
    self.returnAry = [dicData objectForKey:@"data"];
   [resultJSON release];
    if (returnAry == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"传输的数据为空，请检查后台服务。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [myTableView reloadData];
    

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


#pragma mark - tableview dataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"查询结果"; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.returnAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TaskListCellIdentifier = @"PollutionSourceQyertViewController";
	//UITableViewCell *cell = nil;
	NSUInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskListCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TaskListCellIdentifier];
        [cell release];
    }
    NSDictionary *dic = [returnAry objectAtIndex:row];
    NSString *dwmc = [NSString stringWithFormat:@"%@",[dic objectForKey:@"WRYMC"]];
    NSString *dwbh = [dic objectForKey:@"DWDZ"];
    NSString *frdb = [dic objectForKey:@"FRDB"];
    NSString *lxdh = [dic objectForKey:@"LXDH"];
    
    if ([lxdh length] > 0)
        lxdh = [NSString stringWithFormat:@"联系电话:%@",lxdh];
    else
        lxdh = @"";
    
    if ([frdb length] > 0)
        frdb = [NSString stringWithFormat:@"法人代表:%@",frdb];
    else
        frdb = @"";
    
    if ([dwbh length] > 0)
        dwbh = [NSString stringWithFormat:@"单位地址:%@",dwbh];
    else
        dwbh = @"";
    
    cell = [UITableViewCell makeSubCell:tableView withTitle:dwmc SubValue1:dwbh SubValue2:lxdh SubValue3:frdb];
    
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
    if(childtype == KChildQYDA){
        QYDADetailVC *infoController = [[QYDADetailVC alloc] initWithNibName:@"QYDADetailVC" bundle:nil];
        NSUInteger row = indexPath.row;
        NSDictionary *dicBH = [returnAry objectAtIndex:row];
        infoController.wrybh = [dicBH objectForKey:@"WRYBH"];
        infoController.wrymc = [dicBH objectForKey:@"WRYMC"];
        
        [self.navigationController pushViewController:infoController animated:YES];
        [infoController release];

    }
    else {
        PollutionSourceInfoViewController *infoController = [[PollutionSourceInfoViewController alloc] initWithNibName:@"PollutionSourceInfoViewController" bundle:nil];
        NSUInteger row = indexPath.row;
        NSDictionary *dicBH = [returnAry objectAtIndex:row];
        infoController.wrybh = [dicBH objectForKey:@"WRYBH"];
        infoController.wrymc = [dicBH objectForKey:@"WRYMC"];
        
        infoController.serviceType = TYPE_QUERY_WRY_INFO;
        
        [self.navigationController pushViewController:infoController animated:YES];
        [infoController release];
    }
    
}

#pragma mark - Words delegate

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row
{
    switch (currentTag) {
        case 3:
            JGJB.text = words;
            self.jgjbValue = [levelCodeAry objectAtIndex:row];
            break;

        default:
            break;
    }
    
    [wordsPopover dismissPopoverAnimated:YES];
}
#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

@end
