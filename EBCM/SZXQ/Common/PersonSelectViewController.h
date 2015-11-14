//
//  PersonSelectViewController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DepartmentItem;

@protocol  SelectedPersonsDelegate

-(void) returnSelectedPersons:(NSArray*)ary;

@end

@interface PersonSelectViewController : UITableViewController
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) id<SelectedPersonsDelegate> delegate;
@property(nonatomic,retain) NSMutableSet *setSection1;
@property(nonatomic,retain) NSMutableSet *setSection3;

-(id) initWithSelectedPersons:(NSMutableArray*) items andCurrentDepart:(DepartmentItem*)aDepart;


@end
