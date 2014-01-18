//
//  HomepwnerAppDelegate.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "HomepwnerAppDelegate.h"
#import "ItemsViewController.h"

@implementation HomepwnerAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	// Get the full path of our possession archive file
	NSString *possessionPath = [self possessionArrayPath];
	
	// Unarchive it in to an array
	NSMutableArray *possessionArray = 
	[NSKeyedUnarchiver unarchiveObjectWithFile:possessionPath];
	
	// If the file did not exist, our possession array will not either
	// Create one in its absence.
	if (!possessionArray)
		possessionArray = [NSMutableArray array];
	
	// Create an instance of ItemsViewController
	itemsViewController = [[ItemsViewController alloc] init];
	
	// Give it the possessionArray
	[itemsViewController setPossessions:possessionArray];
	
	// Create an instance of a UINavigationController
	// its stack contains only itemsViewController
    UINavigationController *navController = [[UINavigationController alloc] 
            initWithRootViewController:itemsViewController];

    // Place navigation controller's view into window hierarchy
    [window setRootViewController:navController];
    [navController release];
	
	[window makeKeyAndVisible];

	return YES;
}
- (NSString *)possessionArrayPath
{
	return pathInDocumentDirectory(@"Possessions.data");
}
- (void)applicationWillResignActive:(UIApplication *)application
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void)applicationWillTerminate:(UIApplication *)application
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	[self archivePossessions];
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	[self archivePossessions];
}
- (void)archivePossessions
{
	// Get full path of possession archive
	NSString *possessionPath = [self possessionArrayPath];
	
	// Get the possession list
	NSMutableArray *possessionArray = [itemsViewController possessions];
	
	// Archive possession list to file
	[NSKeyedArchiver archiveRootObject:possessionArray toFile:possessionPath];
}
- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
