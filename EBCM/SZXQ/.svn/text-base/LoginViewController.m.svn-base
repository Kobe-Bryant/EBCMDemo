//
//  LoginViewController.m
//  SZXQ
//
//  Created by ihumor on 12-11-16.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "LoginViewController.h"
#import "ClassMaths.h"
#import "MainMenuViewController.h"
#import "JSONKit.h"
#import "ServiceUrlString.h"
#import "LoginedUsrInfo.h"
#import "ZrsUtil.h"
#import "SettingsInfo.h"

#define kNewVertionFound      @"kNewVertionFound"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (IBAction)btnLogIn:(id)sender {
    
    if ([_usrField.text isEqualToString:@""]) {
        NSString *msg = @"用户名不能为空";
		
		[ClassMaths showAlertMsg:msg andDelegate:nil];
        return;
    }
    if ([_pwdField.text isEqualToString:@""]) {
        
        NSString *msg = @"请输入密码";
		[ClassMaths showAlertMsg:msg andDelegate:nil];
        return;
    }
    
    LoginedUsrInfo *usrInfo = [LoginedUsrInfo sharedInstance];
    usrInfo.usr = _usrField.text;
    usrInfo.pwd = _pwdField.text;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"SYSTEM_USER_LOGIN" forKey:@"service"];
    [params setObject:_usrField.text forKey:@"user_login_id"];
    
    NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
    self.webHelper = [[[NSURLConnHelper alloc] initWithUrl:strUrl andParentView:self.view delegate:self] autorelease];
}

-(void)processWebData:(NSData*)webData{
    if([webData length] <=0 ){
        NSString *msg = @"登录失败";
        [ZrsUtil showAlertMsg:msg andDelegate:nil];
        return;
    }
    
    NSString *resultJSON = [[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding] autorelease];
    if([resultJSON isEqualToString:@"404"])
    {
        [ZrsUtil showAlertMsg:@"用户名密码错误。" andDelegate:nil];
        return;
    }
    
    BOOL bFailed = NO;
    NSDictionary *jsonDic = [resultJSON objectFromJSONString];
    if (jsonDic && [jsonDic count] > 0) {
        
        NSDictionary *usrInfoDic = [jsonDic objectForKey:@"user"];
        NSArray *munuInfoAry = [jsonDic objectForKey:@"menus"];
        if (usrInfoDic && munuInfoAry) {
            
            LoginedUsrInfo *usrInfo = [LoginedUsrInfo sharedInstance];
            usrInfo.BMBH = [usrInfoDic objectForKey:@"BMBH"];
            usrInfo.YHMC = [usrInfoDic objectForKey:@"YHMC"];
            usrInfo.aryMenus = munuInfoAry;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_usrField.text forKey:kUser];
            
            MainMenuViewController * menuController= [[[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil] autorelease];
            
            [self.navigationController pushViewController:menuController animated:YES];
        }
        else
        {
            bFailed = YES;
        }
    }else
        bFailed = YES;
    if (bFailed) {
        NSString *msg = @"登录失败";
        [ZrsUtil showAlertMsg:msg andDelegate:nil];
        return;
    }
    
}

-(void)processError:(NSError *)error{
    
    [ZrsUtil showAlertMsg:@"请求数据失败." andDelegate:nil];
    return;
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_webHelper) {
        [_webHelper cancel];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newVertionFound:)
                                                 name:kNewVertionFound
                                               object:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *usr = [defaults objectForKey:kUser];
  
	if (usr == nil) usr= @"";
	_usrField.text = usr;

    
}

- (void)viewDidAppear:(BOOL)animated
{
    //检查是否需要更新
    [NSThread detachNewThreadSelector:@selector(checkVersion) toTarget:self withObject:nil];
    //[self checkVersion];
    [super viewDidAppear:animated];
    
}

-(void)gotoSafari{
        
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://218.4.75.114:8080/ipad/updateapp.html"]];
}

-(void)checkVersion{
    
    NSString *strUrl = @"http://218.4.75.114:8080/ipad/version.json";
    NSURL *url = [NSURL URLWithString:strUrl];
    NSString *resultJSON = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *verInfo = [resultJSON objectFromJSONString];
    NSString *serverVer = [verInfo objectForKey:@"version"];
    NSString *mustUpdate = [verInfo objectForKey:@"mustupdate"];
    CGFloat verFromServer = [serverVer floatValue] *100;
    NSString *settingVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    CGFloat appVer = [settingVer floatValue] *100;
    //mustupdate 0可以忽略此次更新 1 必须更新
    //version 服务器上的最新版本号
    if (verFromServer > appVer) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNewVertionFound object:nil userInfo:[NSDictionary dictionaryWithObject:mustUpdate forKey:@"mustUpdate"]];
    }
}

-(void)infoTipInMainThread:(NSString*)flag{
    if ([flag isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"检测到新版本，请更新。"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
        
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"检测到新版本，是否更新？"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:@"取消",nil];
        [alert show];
        [alert release];
        return;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self gotoSafari];
    }
}


-(void)newVertionFound:(NSNotification *)note{
    NSString *flag = [[note userInfo] objectForKey:@"mustUpdate"];
    
    [self performSelectorOnMainThread:@selector(infoTipInMainThread:) withObject:flag waitUntilDone:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}



- (BOOL)shouldAutorotate
{
    return NO;
   
}
- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_usrField release];
    [_pwdField release];
    [_loginBut release];
    [super dealloc];
}
@end
