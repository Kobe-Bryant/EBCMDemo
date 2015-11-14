    //
//  UIChargeController.m
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIChargeController.h"
#import "UIChargeDetailController.h"
#import "DBHelper.h"
#import "HBWJItem.h"
@interface UIChargeController()
@property(nonatomic,copy) NSString *fidh;
@end

@implementation UIChargeController
@synthesize myTableView,mySearchBar;
@synthesize dataItems,fidh;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"环保手册";
        self.fidh = @"ROOT";
    }
    return self;
}

-(id)initWithFIDH:(NSString*)strFIDH andTitle:(NSString*)aTitle{
    self = [super initWithNibName:@"UIChargeController" bundle:nil];
    if (self) {
        self.title = aTitle;
        self.fidh = strFIDH;
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView.rowHeight = 60;
    
	self.dataItems = [[DBHelper sharedInstance]  queryHBWJItemsByFIDH:fidh];
	[self.myTableView reloadData];
	if([fidh isEqualToString:@"ROOT"]){
        mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 0.0)];
        mySearchBar.delegate = self;
        
        self.navigationItem.titleView = mySearchBar;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];	
    [super viewWillAppear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
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



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataItems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = [indexPath row];
    
   
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    
    HBWJItem *aItem = [dataItems objectAtIndex:index];
    cell.textLabel.text = aItem.FGMC;

    return cell;
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HBWJItem *aItem = [dataItems objectAtIndex:indexPath.row];

	BOOL bHasChild = [aItem.SFML boolValue];
	if (bHasChild) {
		UIChargeController *detailViewController = [[UIChargeController alloc] initWithFIDH:aItem.FGBH andTitle:aItem.FGMC];
	//	detailViewController.title = [dataFGMC objectAtIndex:indexPath.row];
		// Pass the selected object to the new view controller.
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController release];
	}
	else{
		UIChargeDetailController *detailViewController = [[UIChargeDetailController alloc] initWithNibName:@"UIChargeDetailController" bundle:nil];
		detailViewController.title = aItem.FGMC;
		// Pass the selected object to the new view controller.
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController loadHtmlFile:aItem];
		[detailViewController release];
       
        
	}
}



- (void)dealloc {
	[myTableView release];
    [dataItems release];
    [super dealloc];
}

#pragma mark - Search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{
    //searchText = (NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)searchText, nil, nil,kCFStringEncodingUTF8);
    if([searchText isEqualToString:@""]){
        self.dataItems = [[DBHelper sharedInstance]  queryHBWJItemsByFIDH:fidh];
        [self.myTableView reloadData];
    }else {
        self.dataItems = [[DBHelper sharedInstance]  queryWJMCItemsByStr:searchText];
        [myTableView reloadData];
    }
        
    
}

@end
