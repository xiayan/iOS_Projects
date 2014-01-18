//
//  LocalNotifyAppDelegate.h
//  LocalNotify
//
//  Created by Yan Xia on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocalNotifyViewController;

@interface LocalNotifyAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LocalNotifyViewController *viewController;

@end
