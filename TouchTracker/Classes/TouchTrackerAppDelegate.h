//
//  TouchTrackerAppDelegate.h
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TouchDrawView;

@interface TouchTrackerAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet TouchDrawView *touchDrawView;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)archiveCompleteShapes;

@end

