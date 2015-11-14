//
//  AvailableDateListVC.h
//  HNYDZF
//
//  Created by 王 哲义 on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLConnHelper.h"
#import "CommenWordsViewController.h"

@class AvailableDateListVC;

@protocol AvailableDateDelegate

- (void)returnAvailableDate:(NSString *)dateString;

@end

@interface AvailableDateListVC : UIViewController <WordsDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnHelperDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *yearField;
    IBOutlet UITextField *monthField;
}
@property (nonatomic,strong) NSArray * curDateArr;
@property (nonatomic,strong) NSMutableArray * yearArr;
@property (nonatomic,strong) NSMutableArray * monthArr;
@property (nonatomic,strong) UITableView *dateTable;
@property (nonatomic,strong) NSMutableArray *presentAry;
@property (nonatomic,assign) BOOL bEmpty;
@property (nonatomic,assign) NSInteger nParseType;
@property (nonatomic,assign) int currentTag;
@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,strong) NSURLConnHelper *webservice;
@property (nonatomic,assign) id<AvailableDateDelegate> delegate;
@property (nonatomic,strong) UIPopoverController *wordsPopover;
@property (nonatomic,strong) CommenWordsViewController *wordSelectCtrl;

- (id)initWithUrl:(NSString *)url andDelegate:(id)aDelegate andParseType:(NSInteger)type;

@end
