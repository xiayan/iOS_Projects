//
//  TouchViewController.m
//  Touch
//
//  Created by Yan Xia on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TouchViewController.h"

@implementation TouchViewController
@synthesize touchStatus, methodStatus, tapStatus;
@synthesize xCoordinate, yCoordinate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger touchCount = [touches count];
    NSUInteger tapCount = [[touches anyObject] tapCount];
    self.methodStatus.text = @"touchesBegan";
    self.touchStatus.text = [NSString stringWithFormat:@"%i touches", touchCount];
    self.tapStatus.text = [NSString stringWithFormat:@"%i taps", tapCount];
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    self.xCoordinate.text = [[NSString alloc] initWithFormat:@"%f", currentPoint.x];
    self.yCoordinate.text = [[NSString alloc] initWithFormat:@"%f", currentPoint.y];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger touchCount = [touches count];
    NSUInteger tapCount = [[touches anyObject] tapCount];
    self.methodStatus.text = @"touchesMoved";
    self.touchStatus.text = [NSString stringWithFormat:@"%i touches", touchCount];
    self.tapStatus.text = [NSString stringWithFormat:@"%i taps", tapCount];
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    self.xCoordinate.text = [[NSString alloc] initWithFormat:@"%f", currentPoint.x];
    self.yCoordinate.text = [[NSString alloc] initWithFormat:@"%f", currentPoint.y];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger touchCount = [touches count];
    NSUInteger tapCount = [[touches anyObject] tapCount];
    self.methodStatus.text = @"touchesEnded";
    self.touchStatus.text = [NSString stringWithFormat:@"%i touches", touchCount];
    self.tapStatus.text = [NSString stringWithFormat:@"%i taps", tapCount];
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    self.xCoordinate.text = [[NSString alloc] initWithFormat:@"%f", currentPoint.x];
    self.yCoordinate.text = [[NSString alloc] initWithFormat:@"%f", currentPoint.y];
}

@end
