//
//  NSString+MD5Addition.m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UITableViewCell+Custom.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UITableViewCell (Custom)

//一行两项数据的编辑方法(普通表)
+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                         title2:(NSString *)aTitle2
                          value:(NSString *)aValue
                         value2:(NSString *)aValue2
                         height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom6"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom6"] autorelease];
    }
    
	UILabel* tLabel = nil;
    UILabel* tLabel2 = nil;
    UILabel* vLabel = nil;
    UILabel* vLabel2 = nil;
    
	if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
        tLabel2 = (UILabel *)[aCell.contentView viewWithTag:3];
        vLabel2 = (UILabel *)[aCell.contentView viewWithTag:4];
    }
	
	if (tLabel == nil) {
		CGRect tRect1 = CGRectMake(0, 0, 162, aHeight);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentCenter;
        tLabel.numberOfLines = 2;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(162, 0, 222, aHeight);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel.textAlignment = UITextAlignmentLeft;
        vLabel.numberOfLines = 2;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(384, 0, 162, aHeight);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel2.textAlignment = UITextAlignmentCenter;
        tLabel2.numberOfLines = 2;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(546, 0, 222, aHeight);
		vLabel2 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel2.textAlignment = UITextAlignmentLeft;
        vLabel2.numberOfLines = 2;
		vLabel2.tag = 4;
		[aCell.contentView addSubview:vLabel2];
		[vLabel2 release];
        
    }
    
    if (tLabel != nil)  [tLabel setText:aTitle];
    if (vLabel != nil)  [vLabel setText:aValue];
    if (tLabel2 != nil) [tLabel2 setText:aTitle2];
    if (vLabel2 != nil) [vLabel2 setText:aValue2];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	return aCell;
}


//一行四个label
+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                     withValue1:(NSString *)aTitle
                         value2:(NSString *)aTitle2
                         value3:(NSString *)aValue
                         value4:(NSString *)aValue2
                         height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom6"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom6"] autorelease];
    }
    
	UILabel* label1 = nil;
    UILabel* label2 = nil;
    UILabel* label3 = nil;
    UILabel* label4 = nil;
    
	if (aCell.contentView != nil)
	{
        label1 = (UILabel *)[aCell.contentView viewWithTag:1];
        label2 = (UILabel *)[aCell.contentView viewWithTag:2];
        label3 = (UILabel *)[aCell.contentView viewWithTag:3];
        label4 = (UILabel *)[aCell.contentView viewWithTag:4];
    }
	
	if (label1 == nil) {
		CGRect tRect = CGRectMake(0, 0, 190, aHeight);
        NSMutableArray *ary = [NSMutableArray arrayWithCapacity:4];
        for(int i=0;i<4;i++){
            UILabel *tLabel = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [tLabel setBackgroundColor:[UIColor clearColor]];
            [tLabel setTextColor:[UIColor darkGrayColor]];
            tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            tLabel.textAlignment = UITextAlignmentCenter;
            tLabel.numberOfLines = 2;
            tLabel.tag = i+1;
            [aCell.contentView addSubview:tLabel];
            [tLabel release];
            tRect.origin.x += 190;
            [ary addObject:tLabel];
        }
        label1 = [ary objectAtIndex:0];
        label2 = [ary objectAtIndex:1];
        label3 = [ary objectAtIndex:2];
        label4 = [ary objectAtIndex:3];
        
    }
    
    if (label1 != nil)  [label1 setText:aTitle];
    if (label2 != nil)  [label2 setText:aValue];
    if (label3 != nil) [label3 setText:aTitle2];
    if (label4 != nil) [label4 setText:aValue2];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	return aCell;
}

//台账列表显示
+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                     SubValue1:(NSString *)value1 
                     SubValue2:(NSString *)value2 
                     SubValue3:(NSString *)value3
{
    
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom2"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom2"] autorelease];
    }
	UILabel* lblTitle = nil;
	UILabel* lbl1 = nil;
	UILabel* lbl2 = nil;
    UILabel* lbl3 = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lbl1 = (UILabel *)[aCell.contentView viewWithTag:2];
		lbl2 = (UILabel *)[aCell.contentView viewWithTag:3];
        lbl3 = (UILabel *)[aCell.contentView viewWithTag:4];
	}
	
	if (lblTitle == nil) {
		CGRect tRect1 = CGRectMake(20, 2, 460, 48);
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:20.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect2 = CGRectMake(20, 38, 400, 40);
		lbl1 = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lbl1 setBackgroundColor:[UIColor clearColor]];
		[lbl1 setTextColor:[UIColor grayColor]];
		lbl1.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lbl1.textAlignment = UITextAlignmentLeft;
        lbl1.numberOfLines = 2;
		lbl1.tag = 2;
		[aCell.contentView addSubview:lbl1];
		[lbl1 release];
		
		
		CGRect tRect3 = CGRectMake(430, 8, 300, 40);
		lbl2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lbl2 setBackgroundColor:[UIColor clearColor]];
		[lbl2 setTextColor:[UIColor grayColor]];
		lbl2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lbl2.textAlignment = UITextAlignmentRight;
		lbl2.tag = 3;
        lbl2.numberOfLines = 2;
		[aCell.contentView addSubview:lbl2];
		[lbl2 release];
        
        CGRect tRect4 = CGRectMake(430, 38, 300, 40);
		lbl3 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[lbl3 setBackgroundColor:[UIColor clearColor]];
		[lbl3 setTextColor:[UIColor grayColor]];
		lbl3.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lbl3.textAlignment = UITextAlignmentRight;
		lbl3.tag = 4;
        lbl3.numberOfLines = 2;
		[aCell.contentView addSubview:lbl3];
		[lbl3 release];
        
        
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lbl1.backgroundColor = [UIColor clearColor];
		lbl2.backgroundColor = [UIColor clearColor];
        lbl3.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:title];
	if (lbl1 != nil)        [lbl1 setText:value1];
	if (lbl2 != nil)		[lbl2 setText:value2];
    if (lbl3 != nil)		[lbl3 setText:value3];
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return aCell;
}


+(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue
                        height:(NSInteger)aHeight;
{
    UILabel* lblTitle = nil;
	UILabel* lblValue = nil;
	UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellcustom"] autorelease];
    }
    
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];
	}
	
	if (lblTitle == nil) {
		CGRect tRect2 = CGRectMake(5, 0, 160, aHeight);
		lblTitle = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor grayColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lblTitle.textAlignment = UITextAlignmentRight;
        lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect3 = CGRectMake(180, 0, 520, aHeight);
		lblValue = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		lblValue.textAlignment = UITextAlignmentLeft;
        lblValue.numberOfLines = 2;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];
		[lblValue release];
	}
	if (aTitle == nil) aTitle = @"";
    if (aValue == nil) aValue = @"";
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
	
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
	return aCell;
}

+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                        value1:(NSString *)aValue1 
                        value2:(NSString *)aValue2
{
    CGRect tRect1;
    CGRect tRect2;
    CGRect tRect3;
    NSString *cellIdentifier;
	
    tRect1 = CGRectMake(20, 3, 700, 54);
    tRect2 = CGRectMake(25, 56, 150, 24);
    tRect3 = CGRectMake(380, 56, 320, 24);
    cellIdentifier = @"cell_portraitOAList";
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    UILabel* lblTitle = nil;
	UILabel* lblSender = nil;
	UILabel* lblDate = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblSender = (UILabel *)[aCell.contentView viewWithTag:2];
		lblDate = (UILabel *)[aCell.contentView viewWithTag:3];
	}
    
	if (lblTitle == nil) {
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:22.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		lblSender = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblSender setBackgroundColor:[UIColor clearColor]];
		[lblSender setTextColor:[UIColor grayColor]];
		lblSender.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		lblSender.textAlignment = UITextAlignmentLeft;
		lblSender.tag = 2;
		[aCell.contentView addSubview:lblSender];
		[lblSender release];
		
		lblDate = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblDate setBackgroundColor:[UIColor clearColor]];
		[lblDate setTextColor:[UIColor grayColor]];
		lblDate.font = [UIFont fontWithName:@"Helvetica" size:18.0];
		lblDate.textAlignment = UITextAlignmentRight;
		lblDate.tag = 3;
		[aCell.contentView addSubview:lblDate];
		[lblDate release];
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblSender.backgroundColor = [UIColor clearColor];
		lblDate.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:title];
	if (lblSender != nil)	[lblSender setText:aValue1];
	if (lblDate != nil)	[lblDate setText:aValue2];
    
    aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}


//信访列表表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView 
                       withTitle:(NSString *)aTitle
                          caseCode:(NSString *)aCode 
                   complaintDate:(NSString *)aCDate 
                         endDate:(NSString *)aEDate
                            Mode:(NSString *)aMode
{
    CGRect tRect1;
    CGRect tRect2;
    CGRect tRect3;
    CGRect tRect4;
    CGRect tRect5;
    NSString *cellIdentifier;
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        tRect1 = CGRectMake(60, 3, 640, 48);
        tRect2 = CGRectMake(60, 48, 640, 24);
        tRect3 = CGRectMake(700, 48, 300, 24);
        tRect4 = CGRectMake(700, 25, 300, 24);
        tRect5 = CGRectMake(700, 2, 300, 24);
        cellIdentifier = @"cell_landscapeXFList";
        
    } else {
        tRect1 = CGRectMake(60, 3, 440, 48);
        tRect2 = CGRectMake(60, 48, 440, 24);
        tRect3 = CGRectMake(400, 48, 300, 24);
        tRect4 = CGRectMake(500, 25, 200, 24);
        tRect5 = CGRectMake(500, 2, 200, 24);
        cellIdentifier = @"cell_portraitXFList";
    }
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
	UILabel* lblTitle = nil;
	UILabel* lblCode = nil;
	UILabel* lblCDate = nil;
    UILabel* lblEDate = nil;
    UILabel* lblMode = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblCode = (UILabel *)[aCell.contentView viewWithTag:2];
		lblCDate = (UILabel *)[aCell.contentView viewWithTag:3];
        lblEDate = (UILabel *)[aCell.contentView viewWithTag:4];
        lblMode = (UILabel *)[aCell.contentView viewWithTag:5];
	}
	
    
	if (lblTitle == nil) {
		
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:20.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		
		lblCode = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblCode setBackgroundColor:[UIColor clearColor]];
		[lblCode setTextColor:[UIColor grayColor]];
		lblCode.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblCode.textAlignment = UITextAlignmentLeft;
		lblCode.tag = 2;
		[aCell.contentView addSubview:lblCode];
		[lblCode release];
		
		
		
		lblCDate = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblCDate setBackgroundColor:[UIColor clearColor]];
		[lblCDate setTextColor:[UIColor grayColor]];
		lblCDate.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblCDate.textAlignment = UITextAlignmentRight;
		lblCDate.tag = 3;
		[aCell.contentView addSubview:lblCDate];
		[lblCDate release];
        
       
		lblEDate = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[lblEDate setBackgroundColor:[UIColor clearColor]];
		[lblEDate setTextColor:[UIColor grayColor]];
		lblEDate.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblEDate.textAlignment = UITextAlignmentRight;
		lblEDate.tag = 4;
		[aCell.contentView addSubview:lblEDate];
		[lblEDate release];
        
        
		lblMode = [[UILabel alloc] initWithFrame:tRect5]; //此处使用id定义任何控件对象
		[lblMode setBackgroundColor:[UIColor clearColor]];
		[lblMode setTextColor:[UIColor grayColor]];
		lblMode.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblMode.textAlignment = UITextAlignmentRight;
		lblMode.tag = 5;
		[aCell.contentView addSubview:lblMode];
		[lblMode release];
        
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblCode.backgroundColor = [UIColor clearColor];
		lblCDate.backgroundColor = [UIColor clearColor];
        lblEDate.backgroundColor = [UIColor clearColor];
        lblMode.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblCode != nil)     [lblCode setText:aCode];
	if (lblCDate != nil)	[lblCDate setText:aCDate];
    if (lblEDate != nil)	[lblEDate setText:aEDate];
    if (lblMode != nil)     [lblMode setText:aMode];
    
    return aCell;
}

+ (UITableViewCell *)makeSubCell:(UITableView *)tableView 
                       withTitle:(NSString *)aTitle
                    andSubvalue1:(NSString *)aCode 
                    andSubvalue2:(NSString *)aCDate 
                    andSubvalue3:(NSString *)aEDate
                    andSubvalue4:(NSString *)aMode
{
    CGRect tRect1;
    CGRect tRect2;
    CGRect tRect3;
    CGRect tRect4;
    CGRect tRect5;
    NSString *cellIdentifier;
    
    
    tRect1 = CGRectMake(20, 3, 480, 48);
    tRect2 = CGRectMake(20, 48, 380, 24);
    tRect3 = CGRectMake(400, 48, 300, 24);
    tRect4 = CGRectMake(500, 25, 200, 24);
    tRect5 = CGRectMake(500, 2, 200, 24);
    cellIdentifier = @"cell_standingBook";
    
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
	UILabel* lblTitle = nil;
	UILabel* lblCode = nil;
	UILabel* lblCDate = nil;
    UILabel* lblEDate = nil;
    UILabel* lblMode = nil;
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblCode = (UILabel *)[aCell.contentView viewWithTag:2];
		lblCDate = (UILabel *)[aCell.contentView viewWithTag:3];
        lblEDate = (UILabel *)[aCell.contentView viewWithTag:4];
        lblMode = (UILabel *)[aCell.contentView viewWithTag:5];
	}
	
    
	if (lblTitle == nil) {
		
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:20.0];
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		
		lblCode = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblCode setBackgroundColor:[UIColor clearColor]];
		[lblCode setTextColor:[UIColor grayColor]];
		lblCode.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblCode.textAlignment = UITextAlignmentLeft;
		lblCode.tag = 2;
		[aCell.contentView addSubview:lblCode];
		[lblCode release];
		
		
		
		lblCDate = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblCDate setBackgroundColor:[UIColor clearColor]];
		[lblCDate setTextColor:[UIColor grayColor]];
		lblCDate.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblCDate.textAlignment = UITextAlignmentRight;
		lblCDate.tag = 3;
		[aCell.contentView addSubview:lblCDate];
		[lblCDate release];
        
        
		lblEDate = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[lblEDate setBackgroundColor:[UIColor clearColor]];
		[lblEDate setTextColor:[UIColor grayColor]];
		lblEDate.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblEDate.textAlignment = UITextAlignmentRight;
		lblEDate.tag = 4;
		[aCell.contentView addSubview:lblEDate];
		[lblEDate release];
        
        
		lblMode = [[UILabel alloc] initWithFrame:tRect5]; //此处使用id定义任何控件对象
		[lblMode setBackgroundColor:[UIColor clearColor]];
		[lblMode setTextColor:[UIColor grayColor]];
		lblMode.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblMode.textAlignment = UITextAlignmentRight;
		lblMode.tag = 5;
		[aCell.contentView addSubview:lblMode];
		[lblMode release];
        
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblCode.backgroundColor = [UIColor clearColor];
		lblCDate.backgroundColor = [UIColor clearColor];
        lblEDate.backgroundColor = [UIColor clearColor];
        lblMode.backgroundColor = [UIColor clearColor];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblCode != nil)     [lblCode setText:aCode];
	if (lblCDate != nil)	[lblCDate setText:aCDate];
    if (lblEDate != nil)	[lblEDate setText:aEDate];
    if (lblMode != nil)     [lblMode setText:aMode];
    
    return aCell;
}

+(UITableViewCell*)makeMultiLabelsCell:(UITableView *)tableView
                             withTexts:(NSArray *)valueAry
                             andWidths:(NSArray*)widthAry
                             andHeight:(CGFloat)height
                         andIdentifier:(NSString *)identifier
{
    int labelCount = [valueAry count];
    if (labelCount <= 0 || labelCount > 20) {
        return nil;
    }
    UILabel *lblTitle[20];
    
    UITableViewCell *aCell;
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_landscape",identifier];
    aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	
	if (aCell.contentView != nil)
	{
        for (int i =0; i < labelCount; i++)
            lblTitle[i] = (UILabel *)[aCell.contentView viewWithTag:i+1];
        
        
	}
	
	if (lblTitle[0] == nil) {
        CGFloat cellWidth = 1024.0;
        
        CGRect tRect = CGRectMake(0, 0, 0, height);
        for (int i =0; i < labelCount; i++) {
            CGFloat width = [[widthAry objectAtIndex:i] floatValue] *cellWidth;
            tRect.size.width = width;
            lblTitle[i] = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [lblTitle[i] setBackgroundColor:[UIColor clearColor]];
            [lblTitle[i] setTextColor:[UIColor blackColor]];
            lblTitle[i].font = [UIFont systemFontOfSize:20];
            lblTitle[i].textAlignment = UITextAlignmentCenter;
            lblTitle[i].numberOfLines =2;
            lblTitle[i].tag = i+1;
            [aCell.contentView addSubview:lblTitle[i]];
            [lblTitle[i] release];
            tRect.origin.x += width;
        }
        
	}
    
    for (int i =0; i < labelCount; i++){
        [lblTitle[i] setText:@""];
        
    }
    for (int i =0; i < labelCount; i++){
        [lblTitle[i] setText:[valueAry objectAtIndex:i]];
        
    }

	return aCell;
}

+(UITableViewCell*)makeMultiLabelsCell:(UITableView *)tableView
                             withTexts:(NSArray *)valueAry
                             andTableviewWidth:(CGFloat)tablewidth
                             andHeight:(CGFloat)height
                         andIdentifier:(NSString *)identifier
{
    int labelCount = [valueAry count];
    if (labelCount <= 0 || labelCount > 20) {
        return nil;
    }
    UILabel *lblTitle[20];
    
    UITableViewCell *aCell;
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_landscape",identifier];
    aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
	
	if (aCell.contentView != nil)
	{
        for (int i =0; i < labelCount; i++)
            lblTitle[i] = (UILabel *)[aCell.contentView viewWithTag:i+1];
        
        
	}
	
	if (lblTitle[0] == nil) {
        CGFloat width = tablewidth/labelCount;
        CGRect tRect = CGRectMake(0, 0, 0, height);
        for (int i =0; i < labelCount; i++) {
            
            tRect.size.width = width;
            lblTitle[i] = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [lblTitle[i] setBackgroundColor:[UIColor clearColor]];
            [lblTitle[i] setTextColor:[UIColor blackColor]];
            lblTitle[i].font = [UIFont systemFontOfSize:20];
            lblTitle[i].textAlignment = UITextAlignmentCenter;
            lblTitle[i].numberOfLines =2;
            lblTitle[i].tag = i+1;
            [aCell.contentView addSubview:lblTitle[i]];
            [lblTitle[i] release];
            tRect.origin.x += width;
        }
        
	}
    
    for (int i =0; i < labelCount; i++){
        [lblTitle[i] setText:@""];
        
    }
    for (int i =0; i < labelCount; i++){
        [lblTitle[i] setText:[valueAry objectAtIndex:i]];
        
    }
    
    aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
    
    
}


//标签对表栏编辑方法
+(UITableViewCell *)makeCoupleLabelsCell:(UITableView *)tableView 
                             coupleCount:(NSInteger)count 
                              cellHeight:(CGFloat)height 
                              valueArray:(NSArray *)valueAry
{
    if (count > 2 || count < 1) {
        return  nil;
    }
    
    CGFloat totalWidth = 768;
    NSString *cellIdentifier = @"cell_PortraitCoupleLabels";
        
    UITableViewCell *aCell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    UILabel *lblTitle[count*2];
    if (aCell.contentView != nil)
	{
        for (int i =0; i < count*2; i++)
            lblTitle[i] = (UILabel *)[aCell.contentView viewWithTag:i+1];    
	}
    
    if (lblTitle[0] == nil) {
        CGFloat x = 0;
        for (int i =0; i < count*2; i++) {
            CGFloat width;
            UITextAlignment alignment;
            UIColor *textColor;
            
            if (i%2 == 0) {
                width = totalWidth/2/5*2-20;
                textColor = [UIColor grayColor];
                alignment = UITextAlignmentRight;
            } else {
                if (count == 1)
                    width = totalWidth/2/5*8-20;
                else
                    width = totalWidth/2/5*3-20;
                
                textColor = [UIColor blackColor];
                alignment = UITextAlignmentLeft;
            }
            CGRect tRect = CGRectMake(x, 0, width, height);
            lblTitle[i] = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [lblTitle[i] setBackgroundColor:[UIColor clearColor]];
            [lblTitle[i] setTextColor:textColor];
            lblTitle[i].font = [UIFont fontWithName:@"Helvetica" size:19.0];
            lblTitle[i].textAlignment = alignment;
            lblTitle[i].numberOfLines = 0;
            lblTitle[i].tag = i+1;
            [aCell.contentView addSubview:lblTitle[i]];
            [lblTitle[i] release];
            x += (width+10);
        }
	}
    
    for (int i =0; i < count*2; i++){
        [lblTitle[i] setText:@""];
        
    }
    for (int i =0; i < count*2; i++){
        [lblTitle[i] setText:[valueAry objectAtIndex:i]];
        
    }
    
    aCell.selectionStyle = UITableViewCellSelectionStyleNone;
	return aCell;
}


+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                     withValue1:(NSArray *)arrData
                         height:(NSInteger)aHeight
{
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"cellcustom6"];
    if (aCell == nil) {
        aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellcustom6"] autorelease];
            }
    
	UILabel* label1 = nil;
    UILabel* label2 = nil;
    UILabel* label3 = nil;
    UILabel* label4 = nil;
    UILabel* label5 = nil;
    UILabel* label6 = nil;

    
    
	if (aCell.contentView != nil)
	{
        label1 = (UILabel *)[aCell.contentView viewWithTag:1];
        label2 = (UILabel *)[aCell.contentView viewWithTag:2];
        label3 = (UILabel *)[aCell.contentView viewWithTag:3];
        label4 = (UILabel *)[aCell.contentView viewWithTag:4];
        label5 = (UILabel *)[aCell.contentView viewWithTag:5];
        label6 = (UILabel *)[aCell.contentView viewWithTag:6];
    }
	
	if (label1 == nil) {
        CGFloat with = 768/[arrData count];
		CGRect tRect = CGRectMake(0, 0, with, aHeight);
        NSMutableArray *ary = [NSMutableArray arrayWithCapacity:4];
        for(int i=0;i<[arrData count];i++){
            UILabel *tLabel = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
            [tLabel setBackgroundColor:[UIColor clearColor]];
            [tLabel setTextColor:[UIColor darkGrayColor]];
            tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            tLabel.textAlignment = UITextAlignmentCenter;
            tLabel.numberOfLines = 2;
            tLabel.tag = i+1;
            [aCell.contentView addSubview:tLabel];
            [tLabel release];
            tRect.origin.x += with;
            [ary addObject:tLabel];
        }
        CGFloat j = [arrData count];
        if(j-0>0){
            label1 = [ary objectAtIndex:0];
        }
        if(j-1>0){
            label2 = [ary objectAtIndex:1];
        }
        if(j-2>0){
            label3 = [ary objectAtIndex:2];
        }
        if(j-3>0){
            label4 = [ary objectAtIndex:3];
        }
        if(j-4>0)
        {
            label5 = [ary objectAtIndex:4];
        }
        if(j-5>0){
            label6 = [ary objectAtIndex:5];
        }

        
    }
    
    if (label1 != nil)  [label1 setText:[arrData objectAtIndex:0]];
    if (label2 != nil)  [label2 setText:[arrData objectAtIndex:1]];
    if (label3 != nil)  [label3 setText:[arrData objectAtIndex:2]];
    if (label4 != nil)  [label4 setText:[arrData objectAtIndex:3]];
    if (label5 != nil)  [label5 setText:[arrData objectAtIndex:4]];
    if (label6 != nil)  [label6 setText:[arrData objectAtIndex:5]];
    
	return aCell;
}


@end
