//
//  UnitConverterViewController.m
//  UnitConverter
//
//  Created by Yan Xia on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UnitConverterViewController.h"

@implementation UnitConverterViewController
@synthesize resultLabel, tempText;

#pragma mark - IBActions
-(void)convertTemp:(id)sender
{
    double farenheit = [tempText.text doubleValue];
    double celsius = (farenheit - 32) / 1.8;
    
    NSString *resultString = [NSString stringWithFormat:@"Celsius %f", celsius];
    resultLabel.text = resultString;
    
    if ([self isFirstResponder]) {
        [self resignFirstResponder];
    } else {
        for (UIView *view in self.view.subviews) {
            if ([view isFirstResponder]) {
                [view resignFirstResponder];
                break;
            }
        }
    }
}

-(void)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(void)backgroundTouched:(id)sender
{
    [tempText resignFirstResponder];
}

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
    self.resultLabel = nil;
    self.tempText = nil;
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