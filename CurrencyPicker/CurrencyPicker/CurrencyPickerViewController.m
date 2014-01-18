//
//  CurrencyPickerViewController.m
//  CurrencyPicker
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrencyPickerViewController.h"

@implementation CurrencyPickerViewController
@synthesize pikcer, countryNames, exchangeRates;
@synthesize resultLabel, dollarText;

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
    self.countryNames = [[NSArray alloc] initWithObjects:@"Australia (AUD)", @"China (CNY)", @"France (EUR)", @"Great Britain (GBP)", @"Japan (JPY)", nil];
    self.exchangeRates = [[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:0.9922], [NSNumber numberWithFloat:6.5938], [NSNumber numberWithFloat:0.7270], [NSNumber numberWithFloat:0.6206], [NSNumber numberWithFloat:81.57], nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.resultLabel = nil;
    self.dollarText = nil;
    self.pikcer = nil;
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

#pragma mark - Picker datasource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return (NSInteger) 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.countryNames count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.countryNames objectAtIndex:row];
}

#pragma mark - Picker delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    float rate = [[self.exchangeRates objectAtIndex:row] floatValue];
    float dollars = [self.dollarText.text floatValue];
    float result = dollars * rate;
    NSString *country = [self.countryNames objectAtIndex:row];
    
    NSString *resultString = [NSString stringWithFormat:@"%.2f USD = %.2f %@", dollars, result, country];
    
    resultLabel.text = resultString;
}

-(void)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(void)backgroundTouched:(id)sender
{
    if ([self.dollarText isFirstResponder]) {
        [self.dollarText resignFirstResponder];
    }
}

@end
