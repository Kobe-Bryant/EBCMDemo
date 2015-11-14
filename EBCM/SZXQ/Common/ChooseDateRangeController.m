//
//  ChooseDateRangeController.m
//  MonitorPlatform
//
//  Created by 张 仁松 on 12-3-7.
//  Copyright (c) 2012年 博安达. All rights reserved.
//

#import "ChooseDateRangeController.h"

@implementation ChooseDateRangeController
@synthesize delegate,fromPicker,endPicker,datePickerMode;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithPickerMode:(UIDatePickerMode) mode{
	if((self = [super init])){
		datePickerMode = mode;
	}
	return self;
}
/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */
-(IBAction)saveDate:(id)sender{
    
	[delegate choosedFromDate:fromPicker.date andEndDate:endPicker.date];
}



-(IBAction)cancelDate:(id)sender{
	
	[delegate cancelSelectDateRange];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	self.contentSizeForViewInPopover = CGSizeMake(620.0, 260.0);
	UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 35, 300, 216)];
	picker.datePickerMode = datePickerMode;
	[self.view addSubview:picker];
	self.fromPicker = picker;
	[picker release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"开始时间";
    [self.view addSubview:label];
    [label release];
    
    UIDatePicker *picker2 = [[UIDatePicker alloc] initWithFrame:CGRectMake(310, 35, 300, 216)];
	picker2.datePickerMode = datePickerMode;
	[self.view addSubview:picker2];
	self.endPicker = picker2;
	[picker2 release];
    
	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(310, 0, 250, 30)];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [label2 setTextColor:[UIColor blackColor]];
    label2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    label2.textAlignment = UITextAlignmentCenter;
    label2.text = @"结束时间";
    [self.view addSubview:label2];
    [label2 release];
    
	UIBarButtonItem *aButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                    style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDate:)];
    
    self.navigationItem.leftBarButtonItem = aButtonItem;
	[aButtonItem release];
	UIBarButtonItem *aButtonItem2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered 
																	target:self action:@selector(saveDate:)];
    
    self.navigationItem.rightBarButtonItem = aButtonItem2;
	[aButtonItem2 release];
	
}

-(void)viewWillAppear:(BOOL)animated{
	myPicker.date = [NSDate date];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[fromPicker release];
    [endPicker release];
    [super dealloc];
}

@end
