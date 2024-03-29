//
//  SpaceVikingAppDelegate.h
//  SpaceViking
//
//  Created by Rod on 3/2/11.
//  Copyright Prop Group LLC - www.prop-group.com 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface SpaceVikingAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
