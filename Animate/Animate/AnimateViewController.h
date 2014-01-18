//
//  AnimateViewController.h
//  Animate
//
//  Created by Yan Xia on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimateViewController : UIViewController

@property (strong, nonatomic) UIView *boxView;
@property (assign, nonatomic) float scaleFactor;
@property (assign, nonatomic) float angle;

- (UIColor *)randomColor;

@end
