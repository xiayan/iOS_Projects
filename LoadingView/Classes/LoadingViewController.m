//
//  LoadingViewController.m
//  LoadingView
//
//  Created by Matt Gallagher on 12/04/09.
//  Copyright Matt Gallagher 2009. All rights reserved.
// 
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "LoadingViewController.h"
#import "LoadingView.h"

@interface UIApplication (KeyboardView)

- (UIView *)keyboardView;

@end

@implementation UIApplication (KeyboardView)

- (UIView *)keyboardView
{
	NSArray *windows = [self windows];
	for (UIWindow *window in [windows reverseObjectEnumerator])
	{
		for (UIView *view in [window subviews])
		{
			if (!strcmp(object_getClassName(view), "UIKeyboard"))
			{
				return view;
			}
		}
	}
	
	return nil;
}

@end

@implementation LoadingViewController

- (IBAction)showCommit:(id)sender
{
	LoadingView *loadingView =
		[LoadingView loadingViewInView:[self.view.window.subviews objectAtIndex:0]];
	
	[loadingView
		performSelector:@selector(removeView)
		withObject:nil
		afterDelay:5.0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	UIView *keyboardView = [[UIApplication sharedApplication] keyboardView];

	NSLog(@"keyboardView is %p, First responder is %p",
		keyboardView,
		[[[UIApplication sharedApplication]
			keyWindow]
			performSelector:@selector(firstResponder)]);

	LoadingView *loadingView =
		[LoadingView loadingViewInView:keyboardView];
	[self
		performSelector:@selector(dismissKeyboard:)
		withObject:
			[NSDictionary dictionaryWithObjectsAndKeys:
				loadingView, @"loadingView",
				textField, @"textField",
				nil]
		afterDelay:5.0];
	return YES;
}

- (void)dismissKeyboard:(NSDictionary *)aDictionary
{
	[[aDictionary objectForKey:@"loadingView"] removeView];
	[[aDictionary objectForKey:@"textField"] resignFirstResponder];
}

- (void)dealloc {
    [super dealloc];
}

@end
