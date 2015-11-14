//
//  QYDADetailVC.m
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QYDADetailVC.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "QYDAItemDetaiViewController.h"

@implementation QYDADetailVC
@synthesize webservice,wrybh,wrymc;
@synthesize aryItems;


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
    self.title = [NSString stringWithFormat:@"%@企业档案",wrymc];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    [param setObject:@"QUERY_YQYD_INFO" forKey:@"service"];
    [param setObject:wrybh forKey:@"wrybh"];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:param ignoreClientType:NO];
    self.webservice  = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(768.0, 0.0, 300.0, 960.0) style:UITableViewStyleGrouped];
    listTable.delegate = self;
    listTable.dataSource = self;
    [self.view addSubview:listTable];
    [listTable release];
    
    //导航栏按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"查看附件列表" style:UIBarButtonItemStyleDone target:self action:@selector(clickListsTable:)] autorelease];
}

-(void)clickListsTable:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:
     ^{
         if(listTable.frame.origin.x == 768){
             listTable.frame = CGRectMake(768-300, 0, 300, 960);
             [listTable reloadData];
         }else {
             listTable.frame = CGRectMake(768, 0, 300, 960);
         }
         
     }
     ];

    
    
}

- (void)viewDidUnload
{
    [self setWebview:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
	return YES;
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    
    NSMutableString * resultJSON = [[NSMutableString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    if (!isGetList) {
        NSRange  range = [resultJSON rangeOfString:@"###"];
        if (range.length>0) {
            NSRange  range1 = {0,range.location+range.length};
            [resultJSON replaceCharactersInRange:range1 withString:@""];
        }
        
        NSRange range2 = [resultJSON rangeOfString:@"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"shouji\">"];
        NSRange range3 = [resultJSON rangeOfString:resultJSON];
        if (range2.length>0) {
            NSRange range4 = {range2.location+range2.length,range3.length-range2.location-range2.length};
            NSString * secondStr = [NSString stringWithString:[resultJSON substringWithRange:range4]];
            NSRange secondRange = [secondStr rangeOfString:@"<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"shouji\">"];
            NSRange secondRange1 = [secondStr rangeOfString:@"</table>"];
            if (secondRange.length>0) {
                NSRange secondRange2 = {secondRange.location,secondRange1.location+secondRange1.length-secondRange.location};
                NSRange range5 = {range2.location+secondRange2.location,secondRange2.length+range2.length};
                [resultJSON replaceCharactersInRange:range5 withString:@""];
            }
        }
        
        [self.webview loadHTMLString:resultJSON baseURL:[[NSBundle mainBundle] bundleURL]];
        _webview.dataDetectorTypes = UIDataDetectorTypeNone;
        //获取附件列表
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
        [param setObject:@"QUERY_FJ_LIST" forKey:@"service"];
        [param setObject:wrybh forKey:@"wrybh"];
        
        NSString *urlStr = [ServiceUrlString generateUrlByParameters:param ignoreClientType:NO];
        self.webservice  = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
        isGetList = YES;
       
    }
    else{
        NSRange range = [resultJSON rangeOfString:@"data"];
        if (range.length>0) {
            [resultJSON replaceCharactersInRange:range withString:@"\"data\""];
            NSDictionary * resultDic = [resultJSON objectFromJSONString];
            self.aryItems = [resultDic objectForKey:@"data"];
            if (aryItems.count>0) {
                [listTable reloadData];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"没有相关附件!"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
     
        
    }
     [resultJSON release];
    
}

-(void)processError:(NSError *)error
{
    if (!isGetList) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"请求数据失败,请检查网络连接并重试。"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"获取附件列表失败..."
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];

    }
    
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [aryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int row = indexPath.row;
    NSDictionary *dic = [aryItems objectAtIndex:row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MC"]];
  
//    if([[dic objectForKey:@"GS"] isEqualToString:@"pdf"]
//       ){
//        cell.imageView.image = [UIImage imageNamed:@"default_file.png"];
//    }else if([[dic objectForKey:@"GS"] isEqualToString:@".doc"]|| [[dic objectForKey:@"HZM"] isEqualToString:@".docx"]){
//        cell.imageView.image = [UIImage imageNamed:@"doc_file.png"];
//    }
    
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
    QYDAItemDetaiViewController *controller = [[QYDAItemDetaiViewController alloc] initWithNibName:@"QYDAItemDetaiViewController" bundle:nil];
    int row = indexPath.row;
    controller.infoDic = [aryItems objectAtIndex:row];
    controller.filePath = [[aryItems objectAtIndex:row] objectForKey:@"LJ"];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)dealloc {
    
    [aryItems release];
    [_webview release];
    [super dealloc];
}
@end
