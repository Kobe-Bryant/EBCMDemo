//
//  NSString+MD5Addition.h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewCell (Custom)

//一栏两项的编辑方法(普通表)
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView
                       withTitle:(NSString *)aTitle
                          title2:(NSString *)aTitle2
                           value:(NSString *)aValue
                          value2:(NSString *)aValue2
                          height:(NSInteger)aHeight;

+(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue
                        height:(NSInteger)aHeight;



//类似公文列表的表栏编辑方法
+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                        value1:(NSString *)aValue1 
                        value2:(NSString *)aValue2;


//信访列表表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView 
                       withTitle:(NSString *)aTitle
                        caseCode:(NSString *)aCode 
                   complaintDate:(NSString *)aCDate 
                         endDate:(NSString *)aEDate
                            Mode:(NSString *)aMode;

//台账列表表栏编辑方法
+ (UITableViewCell *)makeSubCell:(UITableView *)tableView 
                       withTitle:(NSString *)aTitle
                    andSubvalue1:(NSString *)aCode 
                    andSubvalue2:(NSString *)aCDate 
                    andSubvalue3:(NSString *)aEDate
                    andSubvalue4:(NSString *)aMode;



//widthAry 是所占的百分比
+(UITableViewCell*)makeMultiLabelsCell:(UITableView *)tableView
                             withTexts:(NSArray *)valueAry
                             andWidths:(NSArray*)widthAry
                             andHeight:(CGFloat)height
                         andIdentifier:(NSString *)identifier;

+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                     withValue1:(NSString *)aTitle
                         value2:(NSString *)aTitle2
                         value3:(NSString *)aValue
                         value4:(NSString *)aValue2
                         height:(NSInteger)aHeight;

//标签对表栏编辑方法
+(UITableViewCell *)makeCoupleLabelsCell:(UITableView *)tableView
                             coupleCount:(NSInteger)count
                              cellHeight:(CGFloat)height 
                              valueArray:(NSArray *)valueAry;



+(UITableViewCell*)makeSubCell:(UITableView *)tableView 
                     withTitle:(NSString *)title
                     SubValue1:(NSString *)value1 
                     SubValue2:(NSString *)value2 
                     SubValue3:(NSString *)value3;

+(UITableViewCell*)makeMultiLabelsCell:(UITableView *)tableView
                             withTexts:(NSArray *)valueAry
                     andTableviewWidth:(CGFloat)tablewidth
                             andHeight:(CGFloat)height
                         andIdentifier:(NSString *)identifier;

+ (UITableViewCell*)makeSubCell:(UITableView *)tableView
                     withValue1:(NSArray *)arrData
                         height:(NSInteger)aHeight;
@end
