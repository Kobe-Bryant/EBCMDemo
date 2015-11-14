//
//  WryMapViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WryMapViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "MapPinButton.h"
#import "WryBMKPointAnnotation.h"
#import "PollutionSourceInfoViewController.h"
#import "ServiceType.h"

@interface WryMapViewController ()
@property(nonatomic,retain) BMKMapManager* mapManager;
@property(nonatomic,retain)NSMutableArray *aryAnnotations;
@end

@implementation WryMapViewController
@synthesize mapManager,baiduMapView,urlConnHelper,aryWryItems,listTableView;
@synthesize mcField,mcLabel,dzField,dzLabel,searchBtn,roundField,roundLabel,CLController,userCoordinate;
@synthesize bHaveShow,aryAnnotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 要使用百度地图，请先启动BaiduMapManager
        mapManager = [[BMKMapManager alloc]init];
        BOOL ret = [mapManager start:@"C42968B2FB398D5C63706C36E6467DB772214220" generalDelegate:self];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
    }
    return self;
}

-(IBAction)searchWry:(id)sender{
  
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setObject:@"QUERY_WRY_LIST" forKey:@"service"];
    [params setObject:@"1" forKey:@"queryMap"];
    if ([mcField.text length] > 0) {
        [params setObject:mcField.text forKey:@"wrymc"];
    }
    if ([dzField.text length] > 0) {
        [params setObject:dzField.text forKey:@"dwdz"];
    }
    if ([roundField.text length] > 0) {
        CGFloat jd = userCoordinate.longitude;
        CGFloat wd = userCoordinate.latitude;
        if (jd > 0 && wd > 0) {
            [params setObject:roundField.text forKey:@"round"];
            
            [params setObject:[NSString stringWithFormat:@"%f",jd] forKey: @"jd"];
            [params setObject:[NSString stringWithFormat:@"%f",wd] forKey: @"wd"];
        }
        
    }
    
    //NSString *jsonStr = [params JSONString];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease]; 
}

-(void)wryList:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:
     ^{
         if(listTableView.frame.origin.x == 768){
             listTableView.frame = CGRectMake(768-240, 0, 240, 960);
             
             [listTableView reloadData];
         }else {
             listTableView.frame = CGRectMake(768, 0, 240, 960);
         }
         
     }
     ];
}


- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    mcField.hidden = NO;
    mcLabel.hidden = NO;
    dzField.hidden = NO;
    dzLabel.hidden = NO;
    roundField.hidden = NO;
    roundLabel.hidden = NO;        
    searchBtn.hidden = NO;
}


- (void)showSearchBar:(id)sender {
    listTableView.frame = CGRectMake(768, 0, 240, 960);
    
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender; 
    if(bHaveShow)
    {
        [mcField resignFirstResponder];
        [dzField resignFirstResponder];
        [roundField resignFirstResponder];
        
        bHaveShow = NO;
        aItem.title = @"开启查询";
        mcField.hidden = YES;
        mcLabel.hidden = YES;
        dzField.hidden = YES;
        dzLabel.hidden = YES;
        roundField.hidden = YES;
        roundLabel.hidden = YES;        
        searchBtn.hidden = YES;
        
        [UIView beginAnimations:@"kshowSearchBarAnimation" context:baiduMapView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        baiduMapView.frame = CGRectMake(0, 0, 768, 960);        
        [UIView commitAnimations];
        
    }
    else{
        aItem.title = @"关闭查询";
        bHaveShow = YES;

        [UIView beginAnimations:@"kshowSearchBarAnimation" context:baiduMapView];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        baiduMapView.frame = CGRectMake(0, 120, 768, 960);
        [UIView commitAnimations];
        
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"污染源地图查询";
    
    
    //导航栏按钮
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem  alloc] initWithTitle:@"开启查询" style:UIBarButtonItemStyleBordered  target:self action:@selector(showSearchBar:)];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"污染源列表" style:UIBarButtonItemStyleBordered target:self action:@selector(wryList:)];
    
    
    toolBar.items = [NSArray arrayWithObjects:item3,flexItem,item2,nil];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolBar] autorelease];
    [flexItem release];
    [item3 release];
    [toolBar release];
    // Do any additional setup after loading the view from its nib.
    // 设置mapView的Delegate
    baiduMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
	baiduMapView.delegate = self;
    baiduMapView.zoomLevel = 16;
	[self.view addSubview:baiduMapView];
    
    
    
    [self.view bringSubviewToFront:listTableView];
    listTableView.frame = CGRectMake(768, 0, 240, 960);
    baiduMapView.showsUserLocation = YES;
    
    //roundField.text = @"1000";
    
    bHaveShow = YES;
    [self showSearchBar:item2];
    self.aryAnnotations = [NSMutableArray arrayWithCapacity:100];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    [params setObject:@"QUERY_WRY_LIST" forKey:@"service"];
    [params setObject:@"true" forKey:@"queryMap"];
    CLController = [[CoreLocationController alloc] init];
	CLController.delegate = self;
    [CLController.locMgr startUpdatingLocation];
    
    NSString *urlStr = [ServiceUrlString generateUrlByParameters:params];
    
    if (urlConnHelper)
        [urlConnHelper cancel];
    self.urlConnHelper = [[[NSURLConnHelper alloc] initWithUrl:urlStr andParentView:self.view delegate:self] autorelease];
    [item2 release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)locationUpdate:(CLLocation *)location {
	userCoordinate = location.coordinate;
    
}


- (void)locationError:(NSError *)error {

}

- (void)viewWillDisappear:(BOOL)animated
{
    if (urlConnHelper)
        [urlConnHelper cancel];
    if (CLController) {
       [CLController.locMgr stopUpdatingLocation];
    }
    [super viewWillDisappear:animated];
}

#pragma mark - URLConnHelper delegate
-(void)processWebData:(NSData*)webData
{
 
    

    NSString *resultJSON =[[NSString alloc] initWithBytes: [webData bytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dicData = [resultJSON objectFromJSONString];
    self.aryWryItems = [dicData objectForKey:@"data"];
    
    [resultJSON release];
    if (aryWryItems == nil||[aryWryItems count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未查到相关污染源" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [listTableView reloadData];
        return;
    }
    //苏州高新区

    if (aryAnnotations) {
        [baiduMapView removeAnnotations:aryAnnotations];
        [aryAnnotations removeAllObjects];
    }
    
    
    CLLocationCoordinate2D changshaCoor;
    changshaCoor.latitude = [[[aryWryItems objectAtIndex:0] objectForKey:@"WD"] floatValue];
    changshaCoor.longitude = [[[aryWryItems objectAtIndex:0] objectForKey:@"JD"] floatValue];
     [baiduMapView setCenterCoordinate:changshaCoor animated:YES];
    
    for (NSDictionary *dic in aryWryItems) {
        NSString *jdStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"JD"]];
        NSString *wdStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"WD"]];
        if ([jdStr length] >0 && [wdStr length] > 0) {
            // 添加一个PointAnnotation
            WryBMKPointAnnotation* annotation = [[WryBMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [wdStr floatValue];
            coor.longitude = [jdStr floatValue];

            annotation.coordinate = coor;
            annotation.wrybh = [dic objectForKey:@"WRYBH"];
            annotation.wrymc = [dic objectForKey:@"WRYMC"];
            annotation.title = [dic objectForKey:@"WRYMC"];
            annotation.subtitle = [dic objectForKey:@"DWDZ"];
            [baiduMapView addAnnotation:annotation];
            [aryAnnotations addObject:annotation];
        }
    }
    [listTableView reloadData];
    
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

-(void)selWry:(id)sender{
    
    PollutionSourceInfoViewController *infoController = [[PollutionSourceInfoViewController alloc] initWithNibName:@"PollutionSourceInfoViewController" bundle:nil];


    infoController.wrybh =  [(MapPinButton*)sender wrybh];
    infoController.wrymc = [(MapPinButton*)sender wrymc];

    infoController.serviceType = TYPE_QUERY_WRY_INFO;
    
    [self.navigationController pushViewController:infoController animated:YES];
    [infoController release];
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
       
		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"] autorelease];
		newAnnotation.pinColor = BMKPinAnnotationColorPurple;   
		newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = NO;
		MapPinButton *btn = [[MapPinButton alloc] initWithFrame:CGRectMake(0, 0,35, 35)];
        btn.wrybh = [(WryBMKPointAnnotation*)annotation wrybh];
        btn.wrymc = [(WryBMKPointAnnotation*)annotation wrymc];
        [btn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
        newAnnotation.rightCalloutAccessoryView = btn;
        [btn addTarget:self action:@selector(selWry:) forControlEvents:UIControlEventTouchUpInside];
        [btn release];
		return newAnnotation;
	}
	return nil;
}

-(NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"污染源列表(%d)个",[aryWryItems count]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [aryWryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.numberOfLines =2;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    NSDictionary *dic = [aryWryItems objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.textLabel.text = [dic objectForKey:@"WRYMC"];
    return cell;
}


#pragma mark - Table view delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSDictionary *dic = [aryWryItems objectAtIndex:indexPath.row];
    CLLocationCoordinate2D changshaCoor;
    changshaCoor.latitude = [[dic objectForKey:@"WD"] floatValue];
    changshaCoor.longitude = [[dic objectForKey:@"JD"] floatValue];
    [baiduMapView setCenterCoordinate:changshaCoor animated:YES];
    WryBMKPointAnnotation *annotaton = [aryAnnotations objectAtIndex:indexPath.row];
    [baiduMapView selectAnnotation:annotaton animated:YES];
//    if (_priAnnoView) {
//        ((BMKPinAnnotationView *)_priAnnoView).pinColor = BMKPinAnnotationColorPurple;
//    }
//    for (WryBMKPointAnnotation * anno in aryAnnotations) {
//        if ([[anno wrybh] isEqualToString:[dic objectForKey:@"WRYBH"]]) {
//            
//            
//            
//            BMKAnnotationView * annotationView = [baiduMapView viewForAnnotation:anno];
//            ((BMKPinAnnotationView *)annotationView).pinColor = BMKPinAnnotationColorGreen;
//            self.priAnnoView = annotationView;
//        }
    
//    }

}



-(void)dealloc{
    [_priAnnoView release];
    [aryAnnotations release];
    [aryWryItems release];
    [urlConnHelper release];
    [listTableView release];
    [baiduMapView release];
    [searchBtn release];
    [mcLabel release];
    [mcField release];
    [dzField release];
    [dzLabel release];
    [roundField release];
    [roundLabel release];
    [CLController release];
    [super dealloc];
}
@end
