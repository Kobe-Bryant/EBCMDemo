//
//  AppDelegate.h
//  SZXQ
//
//  Created by ihumor on 12-11-16.
//  Copyright (c) 2012年 ihumor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *viewController;
@property (strong, nonatomic)UINavigationController *navigationController;

@end
