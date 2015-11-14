//
//  ModifyWryLocViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ModifyWryLocViewController.h"
#import "ServiceUrlString.h"
#import "JSONKit.h"
#import "MapPinButton.h"
#import "WryBMKPointAnnotation.h"
#import "ServiceType.h"
#import "ModifyTipViewController.h"

@interface ModifyWryLocViewController ()

@end

@implementation ModifyWryLocViewController
@synthesize wrybh,wrymc,appointWryPosView;
@synthesize baiduMapView,appointJWDLabel,oldJWDLabel;
@synthesize toModifyJD,toModifyWD,oldJD,oldWD;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 要使用百度地图，请先启动BaiduMapManager
        BMKMapManager *mapManager = [[BMKMapManager alloc]init];
        BOOL ret = [mapManager start:@"C42968B2FB398D5C63706C36E6467DB772214220" generalDelegate:self];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
    }
    return self;
}



- (void)handleTap:(UITapGestureRecognizer *)sender { 
    if (sender.state == UIGestureRecognizerStateEnded)     { 
        // handling code   
        if(appointWryPosView == nil){
            
            self.appointWryPosView = [[[MovingImageView alloc] initWithImage:[UIImage imageNamed:@"flag.png"]] autorelease];
            appointWryPosView.userInteractionEnabled = YES;
            appointWryPosView.delegate = self;
            [baiduMapView addSubview:appointWryPosView];

        }
        CGPoint pt = [sender locationInView:baiduMapView];
        appointWryPosView.center = pt;
        CLLocationCoordinate2D coor = [baiduMapView convertPoint:pt toCoordinateFromView:baiduMapView];
        
        self.toModifyWD = [NSString stringWithFormat:@"%f",coor.latitude];
        self.toModifyJD = [NSString stringWithFormat:@"%f",coor.longitude];
        
        appointJWDLabel.text = [NSString stringWithFormat:@"指定经度：%f       指定纬度：%f",coor.longitude,coor.latitude];
    }
}

-(void)didUpdateViewPos{
    CGPoint pt = appointWryPosView.center;
    CLLocationCoordinate2D coor = [baiduMapView convertPoint:pt toCoordinateFromView:baiduMapView];
    // NSLog(@"pt:%f %f",coor.latitude,coor.longitude);
    self.toModifyWD = [NSString stringWithFormat:@"%f",coor.latitude];
    self.toModifyJD = [NSString stringWithFormat:@"%f",coor.longitude];
    
    appointJWDLabel.text = [NSString stringWithFormat:@"指定经度：%f       指定纬度：%f",coor.longitude,coor.latitude];
}

-(void)modifyLocation:(id)sender{
    
    ModifyTipViewController *tipController = [[ModifyTipViewController alloc] initWithNibName:@"ModifyTipViewController" bundle:nil];
    tipController.oldJD = oldJD;
    tipController.oldWD = oldWD;
    tipController.toModifyJD = toModifyJD;
    tipController.toModifyWD = toModifyWD;
    tipController.wrybh = wrybh;
    tipController.wrymc = wrymc;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tipController];
    
    nav.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:nav animated:YES];
    nav.view.superview.frame = CGRectMake(30, 100, 320, 480);
    nav.view.superview.center = self.view.center;
    
    [tipController release];
    [nav release];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = wrymc;
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"提交坐标" style:UIBarButtonItemStyleDone target:self action:@selector(modifyLocation:)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    baiduMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
	baiduMapView.delegate = self;
	[self.view addSubview:baiduMapView];
    baiduMapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D changshaCoor;
    changshaCoor.latitude = [oldWD floatValue];
    changshaCoor.longitude = [oldJD floatValue];
    
    baiduMapView.centerCoordinate = changshaCoor;
    
    oldJWDLabel = [[UILabel alloc] initWithFrame:CGRectMake(550, 0, 218, 60)];
    oldJWDLabel.alpha = 0.9f;
    oldJWDLabel.numberOfLines = 2;
    oldJWDLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:oldJWDLabel];
    appointJWDLabel = [[UILabel alloc] initWithFrame:CGRectMake(550, 60, 218, 60)];
     appointJWDLabel.alpha = 0.9f;
    appointJWDLabel.numberOfLines = 2;
    appointJWDLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:appointJWDLabel];
    
    // 添加一个PointAnnotation

    if ([oldJD length] >0 && [oldWD length] > 0) {
        oldJWDLabel.text = [NSString stringWithFormat:@"原经度：%@ 原纬度：%@",oldJD,oldWD];
        WryBMKPointAnnotation* annotation = [[WryBMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [oldWD floatValue];
        coor.longitude = [oldJD floatValue];
        
        annotation.coordinate = coor;
        annotation.wrybh = wrybh;
        annotation.wrymc = wrymc;
        annotation.title = @"污染源";
        annotation.subtitle = wrymc;
        [baiduMapView addAnnotation:annotation];
        [annotation release];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [baiduMapView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}



// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"] autorelease];
		newAnnotation.pinColor = BMKPinAnnotationColorPurple;   
		newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = NO;
        
		MapPinButton *btn = [[MapPinButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
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


-(void)dealloc{
    
    [baiduMapView release];
    [super dealloc];
}

@end
