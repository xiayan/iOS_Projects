//
//  TouchTrackerAppDelegate.m
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "TouchTrackerAppDelegate.h"
#import "TouchDrawView.h"

@implementation TouchTrackerAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *shapePath = pathInDocumentDirectory(@"shapePath.data");
    
    NSMutableArray *shapeArray = [NSKeyedUnarchiver unarchiveObjectWithFile:shapePath];
    
    if (!shapeArray)
        shapeArray = [NSMutableArray array];
    
    [touchDrawView setCompleteShapes:shapeArray];
 
    [window makeKeyAndVisible];
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

- (void)archiveCompleteShapes
{
    
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSString *shapePath = pathInDocumentDirectory(@"shapePath.data");
    
    NSMutableArray *shapesArray = [[[[self window] subviews] objectAtIndex:0] completeShapes];
    
    [NSKeyedArchiver archiveRootObject:shapesArray toFile:shapePath];
}


@end

