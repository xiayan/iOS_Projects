//
//  MediaPlayerAppDelegate.m
//  MediaPlayer
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "MediaPlayerAppDelegate.h"
#import "MediaPlayerViewController.h"

@implementation MediaPlayerAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	MediaPlayerViewController *vc = [[MediaPlayerViewController alloc] init];
	[window setRootViewController:vc];
	[vc release];
	[window makeKeyAndVisible];
	
	return YES;
}
- (void)dealloc 
{
    [window release];
    [super dealloc];
}


@end
