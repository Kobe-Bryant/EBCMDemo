//
//  SettingsInfo.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingsInfo.h"
#import "UIDevice+IdentifierAddition.h"

@implementation SettingsInfo
@synthesize uniqueDeviceID,ipHeader,version,enableFilterMenu;

static SettingsInfo *_sharedSingleton = nil;
+ (SettingsInfo *) sharedInstance
{
    @synchronized(self)
    {
        if(_sharedSingleton == nil)
        {
            _sharedSingleton = [NSAllocateObject([self class], 0, NULL) init];
        }
    }
    
    return _sharedSingleton;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax; // denotes an object that cannot be released
}

- (oneway void) release
{
    // do nothing
}

- (id) autorelease
{
    return self;
}

#define  kServiceIpKey @"ip_preference"
#define  kmenufilterKey @"menufilter"

-(void)readPreference{
    NSString *testValue = [[NSUserDefaults standardUserDefaults] stringForKey:kServiceIpKey];
	if (testValue == nil)
	{
		NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
        if(!settingsBundle) {
            NSLog(@"Could not find Settings.bundle");
            return;
        }
        
        NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
        NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
        
        NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
        for(NSDictionary *prefSpecification in preferences) {
            NSString *key = [prefSpecification objectForKey:@"Key"];
            if(key) {
                [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            }
        }
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [defaultsToRegister release];
	}
	
	// we're ready to go, so lastly set the key preference values
	self.ipHeader = [[NSUserDefaults standardUserDefaults] stringForKey:kServiceIpKey];
    self.enableFilterMenu = [[NSUserDefaults standardUserDefaults] boolForKey:kmenufilterKey];
}

-(void)readSettings{
    [self readPreference];
    self.version = @"1.0";
    self.uniqueDeviceID = @"ipad";//[[UIDevice currentDevice] macaddress];
}

@end


