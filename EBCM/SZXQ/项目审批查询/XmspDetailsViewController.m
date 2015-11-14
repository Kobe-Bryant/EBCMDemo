 //
//  XmspDetailsViewController.m
//  EditingWord
//
//  Created by power humor on 12-6-28.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "XmspDetailsViewController.h"
#import "ServiceUrlString.h"
#import "HtmlTableGenerator.h"
#import "JSONKit.h"
#import "ServiceType.h"
#import "AttachmentVC.h"

@implementation XmspDetailsViewController
@synthesize wrybh,xmbh;
@synthesize fjArray;
@synthesize urlConnHelper;
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

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
    
    NSMutableString *resultJSON =[[[NSMutableString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
//    NSRange range1 = [resultJSON rangeOfString:@"<link href=\"androidcommon.css\" rel=\"stylesheet\" type=\"text/css\" />"];
//    if (range1.length>0) {
//        [resultJSON replaceCharactersInRange:range1 withString:@""];
//    }
//    
//    NSRange range2 = [resultJSON rangeOfString:@"<!--"];
//    if (range2.length>0) {
//        [resultJSON replaceCharactersInRange:range2 withString:@""];
//    }
//    
//    NSRange range3 = [resultJSON rangeOfString:@"-->"];
//    if (range3.length>0) {
//        [resultJSON replaceCharactersInRange:range3 withString:@""];
//    }


//    NSArray * resultArr = [resultJSON objectFromJSONString];
//    if (resultArr.count==0) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"提示"
//                              message:@"没有数据或是请求数据失败..."
//                              delegate:self
//                              cancelButtonTitle:@"确定"
//                              otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        return;
//
//    }
//    NSMutableDictionary *receiveDic = [NSMutableDictionary dictionaryWithDictionary:[resultArr objectAtIndex:0]];
//    if (![[receiveDic objectForKey:@"XMZTZ_RMB"] isKindOfClass:[NSNull class]]) {
//        //项目总投资金额
//        int touzi = [[receiveDic objectForKey:@"XMZTZ_RMB"] intValue];
//        NSString * touziStr = [NSString stringWithFormat:@"%i万元人民币",touzi];
//        [receiveDic setValue:touziStr forKey:@"XMZTZ_RMB"];
//        
//    }
//    
//    if (![[receiveDic objectForKey:@"HBZTZ_RMB"] isKindOfClass:[NSNull class]]) {
//        //环保总投资金额
//        int touzi = [[receiveDic objectForKey:@"HBZTZ_RMB"] intValue];
//        NSString * touziStr = [NSString stringWithFormat:@"%i万元人民币",touzi];
//        [receiveDic setValue:touziStr forKey:@"HBZTZ_RMB"];
//        
//    }
//    //是否通过审批
//    if (![[receiveDic objectForKey:@"SFTGSP"] isKindOfClass:[NSNull class]]) {
//        [receiveDic setValue:@"通过" forKey:@"SFTG"];
//    }
//    else{
//        [receiveDic setValue:@"未通过" forKey:@"SFTG"];
//    }
//    
//    //返回的数据中审批意见没有 暂时留空
//    [receiveDic setValue:@"" forKey:@"SPYJ"];
//    NSUInteger  serviceType = TYPE_XMSP_DATA_DETAIL;
//    NSString *htmlStr = [HtmlTableGenerator genContentWithTitle:@"项目审批详情" andParaMeters:receiveDic andType:serviceType];
    webview.dataDetectorTypes = UIDataDetectorTypeNone;
    [webview loadHTMLString:resultJSON baseURL:[[NSBundle mainBundle] bundleURL]];
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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"项目审批详情";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"XMSP_DATA_DETAIL" forKey:@"service"];
//    [params setObject:@"json" forKey:@"dataType"];
    [params setObject:xmbh forKey:@"xmbh"];
    NSString *urlString = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlString andParentView:self.view delegate:self] autorelease];
    attachTV.hidden = YES;
    // Do any additional setup after loading the view from its nib.
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
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    [webview release];
    [wrybh release];
    [xmbh release];
    [super dealloc];
}

#pragma mark -
#pragma mark  webview delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    /*
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;  
    [webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];  
     */
    
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([fjArray count] > 0)
        return [fjArray count];
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"attachmentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier] ;
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    
    if ([fjArray count] > 0)
    {
        NSDictionary *tmpDic = [fjArray objectAtIndex:indexPath.row];
        NSString *name = [NSString stringWithFormat:@"%@%@",[tmpDic objectForKey:@"FJMC"],[tmpDic objectForKey:@"HZM"]];
        cell.textLabel.text = name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.textLabel.text = @"没有相关附件";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"没有相关附件"])
        return;
    NSDictionary *tmpDic = [fjArray objectAtIndex:indexPath.row];
    NSString *path = [tmpDic objectForKey:@"LJ"];
    NSString *hzm = [tmpDic objectForKey:@"HZM"];
    NSString *name = [tmpDic objectForKey:@"FJMC"];
    
    AttachmentVC *childVC = [[[AttachmentVC alloc] initWithNibName:@"AttachmentVC" bundle:nil] autorelease];
    childVC.WJMC = name;
    childVC.HZ = hzm;
    childVC.WJLJ = path;
    childVC.gllx = @"XMSP_SMWJ";
    
    [self.navigationController pushViewController:childVC animated:YES];
}

@end
