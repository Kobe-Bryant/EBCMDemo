//
//  MonitorViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MonitorViewController.h"
#import "ServiceUrlString.h"
#import "ZrsUtil.h"
#import "JSONKit.h"
#import "MonitorDetailViewController.h"
#import "UITableViewCell+Custom.h"

@interface MonitorViewController ()

@end

@implementation MonitorViewController
@synthesize webHelper,dataItems,wuranType,dataSave;
//@synthesize mySearchBar;

#pragma mark - Private methods

-(void)requestList{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WRY_BASE_LIST" forKey:@"service"];
    [params setObject:[typeArr objectAtIndex:self.wuranType] forKey:@"type"];
    [params setObject:[outputTypeArr objectAtIndex:wuranType] forKey:@"outputTypeName"];
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self] autorelease];
}

-(void)getCurType:(int)type{
    
    self.wuranType = type;
}

-(void)processWebData:(NSData*)webData{
    
    if (isGetPK) {
        if([webData length] <=0 ){
            NSString *msg = @"获取排口失败";
            [ZrsUtil showAlertMsg:msg andDelegate:nil];
            isGetPK = NO;
            return;
        }
        NSString *resultJSON = [[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] autorelease];
        if([resultJSON isEqualToString:@"404"])
        {
            NSString *msg = @"获取排口失败";
            [ZrsUtil showAlertMsg:msg andDelegate:nil];
            isGetPK = NO;
            return;
        }
        NSArray *jsonAry = [[NSArray alloc] initWithArray:[resultJSON objectFromJSONString]];
        
        if (jsonAry && [jsonAry count] > 0) {
            
            MonitorDetailViewController *detailViewController = [[MonitorDetailViewController alloc] initWithNibName:@"MonitorDetailViewController" bundle:nil];
            detailViewController.wtype = wuranType;
            detailViewController.aItemInfo = jsonAry;
            detailViewController.qymc = curselectQYMC;
            detailViewController.qybh = curselectQYBH;
            [self.navigationController pushViewController:detailViewController animated:YES];
            [detailViewController release];

            
        }else{
            
            [ZrsUtil showAlertMsg:@"没有数据" andDelegate:nil];
        }
        [jsonAry release];
        isGetPK = NO;
    }
    else{
        
        if([webData length] <=0 ){
            NSString *msg = @"获取在线监测站点列表失败";
            [ZrsUtil showAlertMsg:msg andDelegate:nil];
            [mytableView reloadData];
            return;
        }
        
        NSString *resultJSON = [[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
        
        if([resultJSON isEqualToString:@"404"])
        {
            NSString *msg = @"获取在线监测站点列表失败";
            [ZrsUtil showAlertMsg:msg andDelegate:nil];
            [mytableView reloadData];
            return;
        }
        
        NSArray *jsonAry = [[NSArray alloc] initWithArray:[resultJSON objectFromJSONString]];
        
        if (jsonAry && [jsonAry count] > 0) {
            if (!_isCancel) {
                _isCancel = YES;
                self.dataSave = [[NSMutableArray alloc]initWithArray:[resultJSON objectFromJSONString]];
            }
            self.dataItems = jsonAry;
            
        }else{
            [ZrsUtil showAlertMsg:@"没有数据" andDelegate:nil];
        }
        [jsonAry release];
        [mytableView reloadData];
    }
    
   
    
}

-(void)processError:(NSError *)error{
    
    [ZrsUtil showAlertMsg:@"获取在线监测站点列表失败" andDelegate:nil];
    return;
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    switch (self.wuranType) {
        case 0:
            self.title = @"废水污染源自动监测";
            break;
        case 1:
            self.title = @"重金属污染源自动监测";
            break;
        case 2:
            self.title = @"污水处理厂";
            break;
        case 3:
            self.title = @"废气污染源自动监测";
            break;
        case 4:
            self.title = @"油烟监控";
            break;
        case 5:
            self.title = @"放射源自动监测";
            break;
        case 6:
            self.title = @"固废自动监测";
            break;

        default:
            break;
    }
    if (self.wuranType==0) {
         
    }
   
    
    typeArr = [[NSArray alloc] initWithObjects:@"fs",@"fs",@"fs",@"fq",@"fq",@"fsjk",@"fs", nil];
    outputTypeArr = [[NSArray alloc] initWithObjects:@"一般排污口",@"重金属排口",@"污水处理厂排口",@"0",@"1",@"",@"固废排口",nil];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.selectedScopeButtonIndex = 0;
    searchBar.placeholder = @"搜索";

    mytableView.tableHeaderView = searchBar;
    [searchBar release];
    [self requestList];
}

#pragma mark - Search bar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
	searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"搜索"  forState:UIControlStateNormal];
        }
    }
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (![searchText length]) {
        self.dataItems = dataSave;
        [mytableView reloadData];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBarSearchButtonClicked:searchBar];
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [params setObject:@"QUERY_WRY_BASE_LIST" forKey:@"service"];
    [params setObject:[typeArr objectAtIndex:self.wuranType] forKey:@"type"];
    [params setObject:[outputTypeArr objectAtIndex:wuranType] forKey:@"outputTypeName"];
    [params setObject:searchBar.text forKey:@"qymc"];
     
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self] autorelease];
   
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if (webHelper) {
        [webHelper cancel];
    }
    [super viewWillDisappear:animated];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [dataItems count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return 78;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = [indexPath row];
  
    NSDictionary * dic = [dataItems objectAtIndex:index];
    NSString * value1 = [NSString stringWithFormat:@"排口总数:%@",[dic objectForKey:@"排口总数"]];
    UITableViewCell *cell = [UITableViewCell makeSubCell:tableView withTitle:[dic objectForKey:@"企业名称"] value1:value1 value2:@""];
    return cell;
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    curselectQYMC = @"";
    curselectQYBH= @"";
    //首先获取排口信息
    NSString * type =  [typeArr objectAtIndex:self.wuranType];
    NSString * outputTypeName = [outputTypeArr objectAtIndex:wuranType];
    curselectQYMC = [[dataItems objectAtIndex:indexPath.row] objectForKey:@"企业名称"];
    curselectQYBH = [[dataItems objectAtIndex:indexPath.row] objectForKey:@"企业编号"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setObject:@"QUERY_WRY_SITE_LIST" forKey:@"service"];
    [params setObject:curselectQYMC forKey:@"qymc"];
    [params setObject:type forKey:@"type"];
    [params setObject:outputTypeName forKey:@"outputTypeName"];
    isGetPK = YES;
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self] autorelease];
}



- (void)dealloc {
    
    [outputTypeArr release];
    [typeArr release];
	[mytableView release];
    [webHelper release];
    [dataItems release];
    [super dealloc];
}

@end
