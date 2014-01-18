//
//  ContentViewController.h
//  PageApp
//
//  Created by Yan Xia on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *_webView;
@property (strong, nonatomic) id dataObject;

@end
