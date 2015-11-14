//
//  MainMenuViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIArcMenu.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MainMenuViewController : UIViewController<UIScrollViewDelegate>{
    
    NSArray * EPNameArr;
    
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL pageControlIsChangingPage;
@property (nonatomic, retain) IBOutlet UILabel *loginPersonLabel;
- (IBAction)changePage:(id)sender;
- (void)setupPage;
- (void)toggleFromByPage:(NSInteger) nPage ByIndex:(NSInteger) nIndex;

-(IBAction)arcMenuPressed:(id)sender;
@property (nonatomic, retain) UIArcMenu *arcMenu;
@end
