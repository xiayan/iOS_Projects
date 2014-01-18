//
//  FileExampleViewController.m
//  FileExample
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileExampleViewController.h"

@implementation FileExampleViewController
@synthesize textBox;

-(void)saveText:(id)sender
{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dataFile = [docsDir stringByAppendingPathComponent:@"datafile.dat"];
    NSData *dataBuffer = [textBox.text dataUsingEncoding:NSASCIIStringEncoding];
    [filemgr createFileAtPath:dataFile contents:dataBuffer attributes:nil];
    
    if ([self.textBox isFirstResponder]) {
        [self.textBox resignFirstResponder];
    }
}

-(void)textReturn:(id)sender
{
    if (self.textBox.text != nil) {
        [self saveText:nil];
    }
    [sender resignFirstResponder];
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
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPath objectAtIndex:0];
    NSString *dataFile = [docsDir stringByAppendingPathComponent:@"datafile.dat"];
    
    if ([filemgr fileExistsAtPath:dataFile]) {
        NSData *dataBuffer = [filemgr contentsAtPath:dataFile];
        NSString *dataString = [[NSString alloc] initWithData:dataBuffer encoding:NSASCIIStringEncoding];
        textBox.text = dataString;
    }
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

@end
