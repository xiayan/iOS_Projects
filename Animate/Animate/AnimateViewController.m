//
//  AnimateViewController.m
//  Animate
//
//  Created by Yan Xia on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AnimateViewController.h"

@implementation AnimateViewController
@synthesize boxView, scaleFactor, angle;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    self.scaleFactor = 2.0;
    self.angle = 180;
    CGRect frameRect = CGRectMake(10, 10, 45, 45);
    self.boxView = [[UIView alloc] initWithFrame:frameRect];
    boxView.backgroundColor = [self randomColor];
    [self.view addSubview:boxView];
}

- (UIColor *)randomColor
{
    srandom(time(NULL));
    double red = (float)(random() % 10) / 10.0;
    double green = (float)(random() % 10) / 10.0;
    double blue = (float)(random() % 10) / 10.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    // animation block
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    CGAffineTransform rotateTrans = CGAffineTransformMakeRotation(angle * M_PI /180.0);
    self.boxView.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
    self.angle = (angle == 180 ? 360 : 180);
    self.scaleFactor = (scaleFactor == 2 ? 1 : 2);
    self.boxView.center = currentLocation;
    self.boxView.backgroundColor = [self randomColor];
    [UIView commitAnimations];
}

@end
