//
//  ShowHtmlController.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlTableGenerator : NSObject

+(NSString*)genContentWithTitle:(NSString*)aTitle andParaMeters:(NSDictionary*)params
                        andType:(NSInteger)serviceType;

+(NSArray *)genContentWithParaMeters:(NSArray *)params andServiceType:(NSString *)serviceType;
@end
