//
//  BtnsViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BtnsViewController.h"
#import "MainMenuViewController.h"
#import "MenuItem.h"

@interface BtnsViewController ()
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,retain) NSArray *aryNames;
@property(nonatomic,copy) NSString *pageTitle;
@end

@implementation BtnsViewController
@synthesize page,parent,lblTitle,pageTitle,aryNames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPage:(NSInteger)nPage andTitle:(NSString*)aTitle andMenuItemes:(NSArray*)namesAry{
        
	[self initWithNibName:@"BtnsViewController" bundle:nil];
    self.aryNames = namesAry;
    page = nPage;
    self.pageTitle = aTitle;
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    lblTitle.text = pageTitle;
	int w = 110, h =110;
	int n = 4;
	int span = (768 - n * w) / (n + 1);
	int count = [aryNames count];

	for (int i = 0; i < count; i++) {
        
        MenuItem *aItem = [aryNames objectAtIndex:i];
		btn[i]=[[UIButton alloc] initWithFrame:
                CGRectMake(span + (span + w) * (i % n), 
                           span + (span + h) * (i / n) + 35,
                           w, h)];
		btn[i].tag = i ;
        
		btn[i].backgroundColor = [UIColor clearColor];

		[btn[i] setBackgroundImage:[UIImage imageNamed:aItem.imgName] forState:UIControlStateNormal];
        
		
		[btn[i] addTarget:self action:@selector(toggleFrom:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:btn[i]];
		[btn[i] release];
		
		UILabel *btnLabel = [[UILabel alloc] initWithFrame:
                             CGRectMake(span + (span + w) * (i % n), 
                                        span + (span + h) * (i / n) +35 +w,
                                        w, 40)];
		btnLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		btnLabel.numberOfLines = 2;
		btnLabel.text = aItem.title;
		btnLabel.textAlignment = UITextAlignmentCenter;
		btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.contentMode =  UIViewContentModeTop;
		[self.view addSubview:btnLabel];
		[btnLabel release];
	}
}

- (BOOL)shouldAutorotate
{
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}



- (void)toggleFrom:(id)sender{
    
    [(MainMenuViewController*)parent toggleFromByPage:page ByIndex: [sender tag]];
}

-(void) dealloc{

    [aryNames release];
    [lblTitle release];
    [pageTitle release];
    [super dealloc];
}
@end
