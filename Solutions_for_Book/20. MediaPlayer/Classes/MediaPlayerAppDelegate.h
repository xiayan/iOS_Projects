//
//  MediaPlayerAppDelegate.h
//  MediaPlayer
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaPlayerAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

