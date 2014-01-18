//
//  AdAppViewController.m
//  AdApp
//
//  Created by Yan Xia on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AdAppViewController.h"

@implementation AdAppViewController
@synthesize tableView, bannerView;

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
    self.bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.bannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
    self.bannerView.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
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
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    } else {
        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    }
    
    return YES;
}

#pragma mark - AD delegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    self.tableView.tableHeaderView = self.bannerView;
}

@end
