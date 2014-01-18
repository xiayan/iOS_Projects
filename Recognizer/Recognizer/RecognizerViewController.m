//
//  RecognizerViewController.m
//  Recognizer
//
//  Created by Yan Xia on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RecognizerViewController.h"

@implementation RecognizerViewController
@synthesize statusLabel;

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
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
    [self.view addGestureRecognizer:rotationRecognizer];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
    [self.view addGestureRecognizer:swipeRecognizer];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    longPressRecognizer.minimumPressDuration = 3;
    longPressRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:longPressRecognizer];
}

- (void)longPressDetected:(UIGestureRecognizer *)sender
{
    statusLabel.text = @"Long Press";
}

- (void)swipeDetected:(UIGestureRecognizer *)sender
{
    statusLabel.text = @"Right Swipe";
}

- (void)tapDetected:(UIGestureRecognizer *)sender
{
    statusLabel.text = @"Double Tap";
}

- (void)pinchDetected:(UIGestureRecognizer *)sender
{
    CGFloat scale = [(UIPinchGestureRecognizer *)sender scale];
    CGFloat velocity = [(UIPinchGestureRecognizer *)sender velocity];
    NSString *resultString = [NSString stringWithFormat:@"Pinch - scale = %f, velocity = %f", scale, velocity];
    statusLabel.text = resultString;
}

- (void)rotationDetected:(UIGestureRecognizer *)sender 
{
    CGFloat radians = [(UIRotationGestureRecognizer *)sender rotation];
    CGFloat velociry = [(UIRotationGestureRecognizer *) sender velocity];
    NSString *resultString = [NSString stringWithFormat:@"Rotation - Radians = %f, velocity = %f", radians, velociry];
    statusLabel.text = resultString;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.statusLabel = nil;
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

@end
