//
//  ChooseDateRangeController.h
//  MonitorPlatform
//
//  Created by 张 仁松 on 12-3-7.
//  Copyright (c) 2012年 博安达. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseDateRangeDelegate
-(void)choosedFromDate:(NSDate*)fromDate andEndDate:(NSDate*)endDate;
-(void)cancelSelectDateRange;
@end

@interface ChooseDateRangeController : UIViewController {
    
	id<ChooseDateRangeDelegate> delegate;
	UIDatePicker *myPicker;
	UIDatePickerMode datePickerMode;
}
@property (nonatomic, assign) id<ChooseDateRangeDelegate> delegate;
@property (nonatomic, retain) UIDatePicker *fromPicker;
@property (nonatomic, retain) UIDatePicker *endPicker;
@property (nonatomic) UIDatePickerMode datePickerMode;

-(id)initWithPickerMode:(UIDatePickerMode) mode;

@end
