//
//  ArchiveViewController.m
//  Archive
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ArchiveViewController.h"
#import "Person.h"

@implementation ArchiveViewController
@synthesize name, address, phone, dataFilePath;
@synthesize aPerson;


-(void)saveData:(id)sender
{
    if (aPerson == nil) {
        aPerson = [[Person alloc] init];
    }
    
    [self.aPerson setName:self.name.text Address:self.address.text Phone:self.phone.text];
    
    [NSKeyedArchiver archiveRootObject:aPerson toFile:dataFilePath];
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
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    self.dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"data.archive"]];
    
    if ([filemgr fileExistsAtPath:dataFilePath]) {
        self.aPerson = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFilePath];
        
        self.name.text = aPerson.personName;
        self.address.text = aPerson.personAddress;
        self.phone.text = aPerson.personPhone;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.name = nil;
    self.address = nil;
    self.phone = nil;
    self.dataFilePath = nil;
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
