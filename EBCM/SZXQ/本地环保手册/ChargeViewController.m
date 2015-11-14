//
//  ChargeViewController.m
//
//  Created by ... on 12-10-16.
//  Copyright (c) 2012 All rights reserved.
//

#import "ChargeViewController.h"
#import "ChargeDetailVC.h"

@interface ChargeViewController ()

@end

@implementation ChargeViewController

@synthesize unsearchInfo,searchAry;
@synthesize _searchBar,allInfo,viewTitle;
@synthesize firstPageType,bHtmlFile,isUTF8;

#pragma mark - Private methods

- (void)searchForAllChildFiles:(NSArray *)array andSearchString:(NSString *)str
{
    self.searchAry = [NSMutableArray arrayWithCapacity:100];
    
    for (NSDictionary *tmpDic in array)
    {
        NSString *sqlStr = [NSString stringWithFormat:@"select * from t_hbsc where FGMC like \'%%%@%%\' and SFML = \'0\' and FIDH = \'%@\' ",str,[tmpDic objectForKey:@"FGBH"]];
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
        const char *utfsql = [sqlStr cStringUsingEncoding:enc];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK)
        {
            //NSLog(@"search ok.");
        }
        char *name;
        NSString *text;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:20];
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            name=(char *)sqlite3_column_text(statement,0 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"FGBH"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"FGBH"];
            }
            
            name=(char *)sqlite3_column_text(statement,1 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"FGMC"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"FGMC"];
            }
            
            name=(char *)sqlite3_column_text(statement,3 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"SFML"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text  forKey:@"SFML"];
            }
            
            name=(char *)sqlite3_column_text(statement,4 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"WJMC"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"WJMC"];
            }
            
            name=(char *)sqlite3_column_text(statement,5 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"HZM"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"HZM"];
            }
            
            [searchAry addObject:[dic copy]];
        }
        sqlite3_finalize(statement);
    }
    
    if ([searchAry count] > 0)
    {
        [allInfo addObjectsFromArray:searchAry];
    }
    
    [searchAry removeAllObjects];
    
    for (NSDictionary *tmpDic in array)
    {
        NSString *sqlStr = [NSString stringWithFormat:@"select * from t_hbsc where SFML = \'1\' and FIDH = \'%@\' ",[tmpDic objectForKey:@"FGBH"]];
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
        const char *utfsql = [sqlStr cStringUsingEncoding:enc];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK)
        {
            //NSLog(@"search ok.");
        }
        char *name;
        NSString *text;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:20];
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            name=(char *)sqlite3_column_text(statement,0 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"FGBH"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"FGBH"];
            }
            
            name=(char *)sqlite3_column_text(statement,1 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"FGMC"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"FGMC"];
            }
            
            name=(char *)sqlite3_column_text(statement,3 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"SFML"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text  forKey:@"SFML"];
            }
            
            name=(char *)sqlite3_column_text(statement,4 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"WJMC"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"WJMC"];
            }
            
            name=(char *)sqlite3_column_text(statement,5 );
            if (name == NULL) {
                [dic setObject:@"" forKey:@"HZM"];
            }
            else
            {
                text = [NSString stringWithCString:name  encoding:enc];
                [dic setObject:text forKey:@"HZM"];
            }
            
            [searchAry addObject:[dic copy]];
        }
        sqlite3_finalize(statement);
    }
    
    if ([searchAry count] > 0)
        [self searchForAllChildFiles:[searchAry copy] andSearchString:str];
}


-(void)getCurType:(NSString *)str{
    
    self.bHtmlFile = NO;
    self.isUTF8 = YES;
    [self searchByFIDH:str root:self.title];
}

-(void)searchByFIDH:(NSString *)strFIDH root:(NSString *)rootMl{
    self.title = rootMl;
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM T_HBSC WHERE FIDH = '%@' ORDER BY FGBH " ,strFIDH];
    
	NSStringEncoding enc;
    if (isUTF8)
        enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    else
        enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	const char *utfsql = [sqlStr cStringUsingEncoding:enc];
	//NSLog(sqlStr);
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK)
    {
		//NSLog(@"select ok.");
	}
    char *name;
	NSString *text;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:20];

	while (sqlite3_step(statement)==SQLITE_ROW) {
        
        name=(char *)sqlite3_column_text(statement,0 );
        if (name == NULL) {
			[dic setObject:@"" forKey:@"FGBH"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
            [dic setObject:text forKey:@"FGBH"];
        }
        
        name=(char *)sqlite3_column_text(statement,1 );
        if (name == NULL) {
			[dic setObject:@"" forKey:@"FGMC"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
            [dic setObject:text forKey:@"FGMC"];
        }
        
        name=(char *)sqlite3_column_text(statement,3 );
        if (name == NULL) {
			[dic setObject:@"" forKey:@"SFML"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
            [dic setObject:text  forKey:@"SFML"];
        }
        
        name=(char *)sqlite3_column_text(statement,4 );
        if (name == NULL) {
			[dic setObject:@"" forKey:@"WJMC"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
            [dic setObject:text forKey:@"WJMC"];
        }
        
        name=(char *)sqlite3_column_text(statement,5 );
        if (name == NULL) {
			[dic setObject:@"" forKey:@"HZM"];
		}
        else
        {
            text = [NSString stringWithCString:name  encoding:enc];
            [dic setObject:text forKey:@"HZM"];
        }
        
        self.unsearchInfo = [allInfo copy];
        
        [allInfo addObject:[dic copy]];
	}
    
    
	sqlite3_finalize(statement);
        
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 0.0)];
    _searchBar.delegate = self;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    NSMutableArray *ary5 = [[NSMutableArray alloc] initWithCapacity:130];
	self.allInfo = ary5;
	[ary5 release];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
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

- (void)viewWillAppear:(BOOL)animated
{
    NSString *dataDbPath = [[NSBundle mainBundle] pathForResource:@"handbook_data" ofType:@"db"];
	if (sqlite3_open([dataDbPath UTF8String], &data_db)!=SQLITE_OK) {
		//NSLog(@"open datadb sqlite db error.");
	}
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    sqlite3_close(data_db);
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [nameArr release];
	[myTableView release];
    [allInfo release];
    [unsearchInfo release];
    [searchAry release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [allInfo count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = [indexPath row];
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    // Configure the cell...
    //  NSString *image = [NSString stringWithFormat:@"mc_%d",indexPath.row];
    //  cell.imageView.image = [UIImage imageNamed:image];
    
    /* NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(index%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
     UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
     cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];*/
    cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cell.backgroundView.frame = cell.bounds;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    cell.textLabel.numberOfLines = 0;
    
    NSMutableDictionary *dic = [allInfo objectAtIndex:index];
    cell.textLabel.text = [dic objectForKey:@"FGMC"];
    
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"??d‰∏?,[dataFGBH count]];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];
    
    NSDictionary *dic = [allInfo objectAtIndex:row];
    NSString *boolStr = [dic objectForKey:@"SFML"];
	BOOL bHasChild = [boolStr boolValue];
    if (bHasChild)
    {
        ChargeViewController *detailViewController = [[ChargeViewController alloc] initWithNibName:@"ChargeViewController" bundle:nil];
        detailViewController.firstPageType = PAGE_TYPE_NONE;
        //	detailViewController.title = [dataFGMC objectAtIndex:indexPath.row];
        // Pass the selected object to the new view controller.
        detailViewController.isUTF8 = self.isUTF8;
        detailViewController.bHtmlFile = self.bHtmlFile;
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController searchByFIDH:[dic objectForKey:@"FGBH"] root:[dic objectForKey:@"FGMC"]];
        [detailViewController release];
    }
    else
    {
        ChargeDetailVC *detailViewController = [[ChargeDetailVC alloc] initWithNibName:@"ChargeDetailVC" bundle:nil];
        detailViewController.title = [dic objectForKey:@"FGMC"];
        detailViewController.bhtml = bHtmlFile;
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        if (bHtmlFile)
            [detailViewController loadHtmlFile:[dic objectForKey:@"WJMC"]];
        else
            
        [detailViewController loadOtherFile:[dic objectForKey:@"WJMC"] andFormatter:[dic objectForKey:@"HZM"]];
        [detailViewController release];
        
    }
	
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [allInfo removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        self.allInfo = [unsearchInfo mutableCopy];
    }
    else
    {
        [self searchForAllChildFiles:unsearchInfo andSearchString:searchText];
    }
    
    [myTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}

@end
