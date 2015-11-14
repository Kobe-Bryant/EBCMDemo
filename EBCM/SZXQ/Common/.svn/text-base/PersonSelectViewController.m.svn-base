//
//  PersonSelectViewController.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonSelectViewController.h"
#import "PersonItem.h"
#import "DepartmentItem.h"
#import "DBHelper.h"

@interface PersonSelectViewController ()
@property(nonatomic,retain) NSMutableArray *arySelectedPersons;
@property(nonatomic,retain) NSArray *aryDeparts;
@property(nonatomic,retain) NSArray *aryChildPersons;
@property(nonatomic,retain) DepartmentItem *currentDepartment;


//setSection1 存储arySelectedPersons中标注checkmark的PersonItem
//setSection3 存储aryChildPersons中标注checkmark的PersonItem

@end

@implementation PersonSelectViewController
@synthesize arySelectedPersons,delegate,aryChildPersons;
@synthesize aryDeparts,currentDepartment;
@synthesize setSection1,setSection3;
#define kSelectedPersonTable  1
#define kWholePersonTable     2 //右边所有用户的tableview tag

-(id) initWithSelectedPersons:(NSMutableArray*) items andCurrentDepart:(DepartmentItem*)aDepart{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        if(items != nil)
            self.arySelectedPersons = items;
        else 
            self.arySelectedPersons = [NSMutableArray arrayWithCapacity:10];
        
        if(aDepart != nil)
            self.currentDepartment = aDepart;
        else{
            DepartmentItem *aItem = [[DepartmentItem alloc] init];
            aItem.BMBH = @"ROOT";
            aItem.BMMC = @"湖南省环境保护厅";
            self.currentDepartment = aItem;
            [aItem release];
            
            self.setSection1 = [NSMutableSet setWithCapacity:10];
            self.setSection3 = [NSMutableSet setWithCapacity:10];
        }
        
    }
    return self;
}

//从本度数据库中获取人员信息
-(void)requestYHDatas{
    self.aryDeparts = [[DBHelper sharedInstance] queryChildDepartments:currentDepartment.BMBH];
    self.aryChildPersons = [[DBHelper sharedInstance]  queryPersonsByBMBH:currentDepartment.BMBH];
}

-(void)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save:(id)sender{
    [delegate returnSelectedPersons:arySelectedPersons];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = currentDepartment.BMMC;
    
    if(![currentDepartment.BMBH isEqualToString:@"ROOT"]){
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"返回上一级"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(goBack:)];
        self.navigationItem.leftBarButtonItem = backButton;
        [backButton release];
    }
    else
    {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"取消"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem = backButton;
        [backButton release];
    }
    
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"选择完毕" 
								   style:UIBarButtonItemStyleDone
								   target:self
								   action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
    
    [self requestYHDatas];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
        
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

        if(section == 0) 
            return @"已选人员";
        else if(section == 1)
            return @"下属部门";
        else 
            return @"部门人员";

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

        if(section == 0) 
            return [arySelectedPersons count];
        else if(section == 1)
            return [aryDeparts count];
        else 
            return [aryChildPersons count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
	return 42;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *Identifier = @"PSCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier] autorelease];
        
        cell.textLabel.numberOfLines =3;
        cell.textLabel.font = [UIFont  systemFontOfSize:18.0];
        cell.detailTextLabel.font = [UIFont  systemFontOfSize:16.0];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
	}
    
    if(indexPath.section == 0) {
        PersonItem* aItem = [arySelectedPersons objectAtIndex:indexPath.row];
        cell.textLabel.text = aItem.yhmc;
        if([setSection1 containsObject:aItem])
           cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else 
            cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else if(indexPath.section == 1){
        cell.textLabel.text = [[aryDeparts objectAtIndex:indexPath.row] BMMC];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else if(indexPath.section == 2){
        PersonItem* aItem = [aryChildPersons objectAtIndex:indexPath.row];
        cell.textLabel.text = aItem.yhmc;
        if([setSection3 containsObject:aItem])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else 
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
	return cell;
	
    
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        PersonItem* aItem = [arySelectedPersons objectAtIndex:indexPath.row];
        if ([setSection1 containsObject:aItem]) {
            [setSection1 removeObject:aItem];
        }else {
            [setSection1 addObject:aItem];
        }
        [self.tableView reloadData];
    }
    else if(indexPath.section == 1){
        DepartmentItem *selItem = [aryDeparts objectAtIndex:indexPath.row];
        selItem.parent = currentDepartment;
  
        
        PersonSelectViewController *controller = [[PersonSelectViewController alloc] initWithSelectedPersons:arySelectedPersons andCurrentDepart:selItem];
        controller.setSection1 = setSection1;
        controller.setSection3 = setSection3;
        controller.delegate = delegate;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(indexPath.section == 2){
        PersonItem* aItem = [aryChildPersons objectAtIndex:indexPath.row];
        if ([setSection3 containsObject:aItem]) {
            [setSection3 removeObject:aItem];
            [arySelectedPersons removeObject:aItem];
            [setSection1 removeObject:aItem];
        }else {
            [setSection3 addObject:aItem];
             [arySelectedPersons addObject:aItem];
            [setSection1 addObject:aItem];
            
        }
        [self.tableView reloadData];
    }
}

@end
