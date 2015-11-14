//
//  WryMapViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "NSURLConnHelper.h"
#import "CoreLocationController.h"

@interface WryMapViewController : UIViewController<BMKGeneralDelegate,BMKMapViewDelegate,NSURLConnHelperDelegate,CoreLocationControllerDelegate>

@property(nonatomic,retain)  BMKMapView* baiduMapView;
@property(nonatomic,strong)  NSURLConnHelper *urlConnHelper;
@property(nonatomic,retain)  NSArray *aryWryItems;
@property(nonatomic,retain) IBOutlet UITableView *listTableView;
@property(nonatomic,retain) IBOutlet UIButton *searchBtn;
@property(nonatomic,retain) IBOutlet UILabel *mcLabel;
@property(nonatomic,retain) IBOutlet UILabel *dzLabel;
@property(nonatomic,retain) IBOutlet UILabel *roundLabel;
@property(nonatomic,retain) IBOutlet UITextField *mcField;
@property(nonatomic,retain) IBOutlet UITextField *dzField;
@property(nonatomic,retain) IBOutlet UITextField *roundField;
@property (nonatomic, retain) CoreLocationController *CLController;
@property(nonatomic,assign)CLLocationCoordinate2D userCoordinate;
@property(nonatomic,assign) BOOL bHaveShow;
@property(nonatomic,assign) BMKAnnotationView * priAnnoView;
-(IBAction)searchWry:(id)sender;
@end
