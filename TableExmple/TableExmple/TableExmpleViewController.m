//
//  TableExmpleViewController.m
//  TableExmple
//
//  Created by Yan Xia on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TableExmpleViewController.h"

@implementation TableExmpleViewController
@synthesize colorNames;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.colorNames = [[NSArray alloc] initWithObjects:@"Red", @"Green", @"Blue", @"Indigo", @"Violet", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.colorNames = nil;
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

#pragma mark - table view datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colorNames count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    UIImage *image = [UIImage imageNamed:@"SimpleApple.png"];
    cell.imageView.image = image;
    NSString *cellTitle = [self.colorNames objectAtIndex:indexPath.row];
    cell.textLabel.text = cellTitle;
    NSString *subtitle = [NSString stringWithString:@"All about the color "];
    subtitle = [subtitle stringByAppendingString:cellTitle];
    cell.detailTextLabel.text = subtitle;

    return cell;
}

@end
