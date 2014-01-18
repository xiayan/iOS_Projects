//
//  TouchAppDelegate.h
//  Touch
//
//  Created by Yan Xia on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchViewController;

@interface TouchAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TouchViewController *viewController;

@end
