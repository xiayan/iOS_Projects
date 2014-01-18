//
//  ItemInfoHeaderViewController.m
//  LabOrganizer
//
//  Created by Yan Xia on 3/30/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "ItemInfoHeaderViewController.h"
#import "Item.h"
#import "ItemHeaderTableViewCell.h"

@implementation ItemInfoHeaderViewController
@synthesize item, undoManager;
@synthesize pickerViewContainer, infoTableView, infoView, nameLabel, itemHeaderTableViewCell;

static BOOL cancel;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
*/

- (id)initWithItem:(Item *)newItem
{
    self = [super initWithNibName:@"ItemInfoHeaderViewController" bundle:nil];
    self.item = newItem;
    undoManager = [[NSUndoManager alloc] init];
    NSManagedObjectContext *moc = self.item.managedObjectContext;
    [moc setUndoManager:undoManager];
    
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.item.name;
    [pickerViewContainer addSubview:infoView];
    self.infoTableView.allowsSelection = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.pickerViewContainer = nil;
    self.infoTableView = nil;
    self.infoView = nil;
    self.nameLabel = nil;
    self.itemHeaderTableViewCell = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    cancel = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (editing) {
        [infoView removeFromSuperview];
        [pickerViewContainer addSubview:infoTableView];
        [undoManager beginUndoGrouping];
    } else {
        [infoTableView removeFromSuperview];
        [pickerViewContainer addSubview:infoView];
        if (cancel) {
            [undoManager endUndoGrouping];
            [self.item.managedObjectContext rollback];
            [undoManager removeAllActions];
            [self.infoTableView reloadData];
            cancel = NO;
        } else {
            [undoManager removeAllActions];
            [self saveChanges];
        }
        
        self.nameLabel.text = self.item.name;
    }
}

#pragma mark - Button Methods

- (IBAction)ordered:(id)sender
{
    NSLog(@"Will implement later");
}

- (void)saveChanges
{
    ItemHeaderTableViewCell *cell = (ItemHeaderTableViewCell *)[self.infoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.item.name = cell.textField.text;
}

- (void)cancelChanges
{
    cancel = YES;
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemHeaderTableViewCell";
    static NSString *DefaultCellIdentifier = @"DefaultCellIdentifier";
    
    ItemHeaderTableViewCell *cell = (ItemHeaderTableViewCell *) [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
     UITableViewCell *defaultCell = (UITableViewCell *) [aTableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ItemHeaderTableViewCell" owner:self options:nil];
        cell = itemHeaderTableViewCell;
        self.itemHeaderTableViewCell = nil;
    }
    
    if (defaultCell == nil) {
        defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:DefaultCellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.label.text = @"Name";
            cell.textField.text = self.item.name;
            break;
        case 1:
            defaultCell.textLabel.text = @"Quantity";
            defaultCell.detailTextLabel.text = [NSString stringWithFormat:@"%i", self.item.quantity];
            return defaultCell;
            break;
        case 2:
            defaultCell.textLabel.text = @"Next Date";
            return defaultCell;
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    ItemHeaderTableViewCell *cell = (ItemHeaderTableViewCell *) [[textField superview] superview];
    
    if (cell.label.text == @"Name") {
        if ([textField.text isEqualToString:@""]) {
            self.item.name = @"Untitled Item";            
        } else {
            self.item.name = textField.text;
        }
    }
    
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end
