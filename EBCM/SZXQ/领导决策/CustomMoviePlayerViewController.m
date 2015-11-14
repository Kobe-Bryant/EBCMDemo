//
//  CustomMoviePlayerViewController.m
//  SZXQ
//
//  Created by ihumor on 13-5-27.
//  Copyright (c) 2013年 ihumor. All rights reserved.
//

#import "CustomMoviePlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CustomMoviePlayerViewController ()

@end

@implementation CustomMoviePlayerViewController
@synthesize movieURL;
@synthesize mp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    mp = [[MPMoviePlayerController alloc] initWithContentURL: movieURL];
    [mp setScalingMode:MPMovieScalingModeAspectFit];
    [mp prepareToPlay];
    [mp.view setFrame: self.view.bounds];  // player's frame must match parent's
    [self.view addSubview: mp.view];
    // ...
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [mp play];
    
}

#pragma mark -  dealloc

- (void)dealloc
{
    [mp stop];
    mp.contentURL = nil;
    [mp release];
    [movieURL release];
    [loadingAni release];
    [label release];
    
    [super dealloc];
}

@end
