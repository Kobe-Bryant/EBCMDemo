//
//  BtnsViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#define MAX_BUTTON_COUNT 16

@interface BtnsViewController : UIViewController {
	UILabel* lblTitle;
	UIButton* btn[MAX_BUTTON_COUNT];
    
	
	UIViewController* parent;
}

@property (assign) UIViewController* parent;
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;


- (id)initWithPage:(NSInteger)nPage andTitle:(NSString*)aTitle andMenuItemes:(NSArray*)namesAry;
- (void)toggleFrom:(id)sender;

@end
