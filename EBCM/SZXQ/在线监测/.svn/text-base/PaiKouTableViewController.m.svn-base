//
//  PaiKouTableViewController.m
//  SZXQ
//
//  Created by ihumor on 12-11-28.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import "PaiKouTableViewController.h"

@interface PaiKouTableViewController ()

@end

@implementation PaiKouTableViewController
@synthesize delegage,curWuRanType;

- (id)initWithStyle:(UITableViewStyle)style AndInfoArr:(NSArray *)arr AndCurSelect:(int)curSelect
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        curTag = curSelect;
        paiKouInfoArr = [[NSArray alloc] initWithArray:arr];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.curWuRanType==CHOOSEYEAR) {
        self.title = @"请选择年份";
    }
    else if(self.curWuRanType==TJPORT){
        self.title = @"所有水站列表:";
    }
    else if (self.curWuRanType == LZTJFJ){
        self.title = @"附件列表:";
    }
    else{
        self.title = @"所有排口列表:";
    }
    
}

-(void)dealloc{
    delegage  = nil;
    [paiKouInfoArr release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return paiKouInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (curTag==indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(self.curWuRanType==WURANYUANTYPE){
        
         cell.textLabel.text = [[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"放射源名称"];
        
    }
    else if(self.curWuRanType==CHOOSEYEAR){
        
        cell.textLabel.text =[NSString stringWithFormat:@"%@年",[paiKouInfoArr objectAtIndex:indexPath.row]];
    }
    else if(self.curWuRanType==TJPORT){
        
        cell.textLabel.text =[[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"站点名称"];
    }
    else if(self.curWuRanType==LZTJFJ){
        for (UIView *view in cell.subviews) {
            if (view.tag == 10) {
                [view removeFromSuperview];
            }
        }
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10.0,1.0, 150.0, cell.frame.size.height-2)];
        lb.text = [[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"DisplayName"];
        lb.tag = 10;
        [cell addSubview:lb];
        [lb release];
        
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(180.0,1.0, 110.0, cell.frame.size.height-2)];
        lb1.text = [NSString stringWithFormat:@"大小：%@",[[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"Filesize"]];
        lb1.tag = 10;
        [cell addSubview:lb1];
        [lb1 release];
        
        UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(300.0,1.0, 230.0, cell.frame.size.height-2)];
        lb2.text = [NSString stringWithFormat:@"上传时间：%@",[[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"UpdateTime"]];
        lb2.tag = 10;
        [cell addSubview:lb2];
        [lb2 release];
        /*
        UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(500.0,1.0, 100.0, cell.frame.size.height-2)];
        lb3.text = [NSString stringWithFormat:@"上传人:%@",[[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"UpdateUser"]];
        lb3.tag = 10;
        [cell addSubview:lb3];
        [lb3 release];*/
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
         cell.textLabel.text = [[paiKouInfoArr objectAtIndex:indexPath.row] objectForKey:@"排口名称"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.delegage didSelectPaiKou:[paiKouInfoArr objectAtIndex:indexPath.row] AndCurSelect:indexPath.row];
}

@end
