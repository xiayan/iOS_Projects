//
//  LocationDetailTableViewController.m
//  LabOrganizer
//
//  Created by Yan Xia on 4/13/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "LocationDetailTableViewController.h"
#import "Item.h"
#import "ItemDetailViewController.h"
#import "CompanyTableViewCell.h"
#import "HelperCategories.h"

static NSMutableArray *changedItems;
static BOOL cancel;

#define LOCATIONINFO_SECTION 0
#define ITEMLIST_SECTION 1

@implementation LocationDetailTableViewController
@synthesize location, itemList, locationFooterView, companyTableViewCell;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (id)initWithLocation:(NSManagedObject *)newLocation
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.location = newLocation;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
        NSManagedObjectContext *moc = [self.location managedObjectContext];
        undoManager = [[NSUndoManager alloc] init];
        [moc setUndoManager:self.undoManager];
    }
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
    self.navigationItem.title = [self.location valueForKey:@"place"];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.locationFooterView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    cancel = NO;
    NSSet *items = [self.location valueForKey:@"items"];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *array = [[items allObjects]sortedArrayUsingDescriptors:sortDescriptors];
    
    self.itemList = [array mutableCopy];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    itemList = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!editing) {
        // Save changes when "Done" is pressed
        // If cancel is pressed, rollback
        if (cancel) {
            [undoManager endUndoGrouping];
            NSManagedObjectContext *moc = [self.location valueForKey:@"managedObjectContext"];
            [moc rollback];
            cancel = NO;
            
            if (changedItems) {
                if ([changedItems count] > 0) {
                    [itemList addObjectsFromArray:changedItems];
                    [itemList sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
                }
            }
        } else {
            [self saveChanges];
        }
        
        // Get rid of the cancel button and footerview when not editing
        self.navigationItem.leftBarButtonItem = nil;
        self.tableView.tableFooterView = nil;
        
        // Clean up the changedItem array
        if (changedItems) {
            [changedItems removeAllObjects];
            changedItems = nil;
        }
        
        // Discard all the stuff on undo stack
        [undoManager removeAllActions];
        
        NSManagedObjectContext *context = [self.location valueForKey:@"managedObjectContext"];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        self.navigationItem.title = [self.location valueForKey:@"place"];
    } else {
        if (!locationFooterView) {
            [[NSBundle mainBundle] loadNibNamed:@"LocationFooterView" owner:self options:nil];
        }
        self.tableView.tableFooterView = self.locationFooterView;
        
        // When editing, put a cancel button so that the changes can be omitted
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelChanges:)];
        self.navigationItem.leftBarButtonItem = leftButton;
        
        // Start registering changes
        [undoManager beginUndoGrouping];
    }
    
    [self.tableView reloadData:YES];

}

#pragma mark - Button Methods

- (void)deleteLocation:(id)sender
{
    NSManagedObjectContext *context = [self.location valueForKey:@"managedObjectContext"];
    
    [context deleteObject:self.location];
    
    NSError *error = nil;
	if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}	
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveChanges
{
    NSString *newName = [self textForRow:0];
    [self.location setValue:newName forKey:@"place"];
}

- (NSString *)textForRow:(NSUInteger)row
{
    CompanyTableViewCell *cell = (CompanyTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    return cell.textField.text;
}

- (void)cancelChanges:(id)sender
{
    cancel = YES;    
    self.editing = NO;    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = nil;
    
    if (section == LOCATIONINFO_SECTION) {
        sectionTitle = @"Location Name";
    } else if (section == ITEMLIST_SECTION) {
        if ([itemList count] == 0) {
            sectionTitle = @"No Item";
        } else {
            sectionTitle = @"Item List";
        }
    }
    return sectionTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numberOfRows = 0;
    
    switch (section) {
        case LOCATIONINFO_SECTION:
            numberOfRows = 1;
            break;
        case ITEMLIST_SECTION:
            numberOfRows = [itemList count];
            break;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *DefaultCellIdentifier = @"DefaultCellIdentifier";
    
    CompanyTableViewCell *cell = (CompanyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *defaultCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"LocationDetailTableViewCell" owner:self options:nil];
        cell = companyTableViewCell;
        self.companyTableViewCell = nil;
    }
    if (defaultCell == nil) {
        defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCellIdentifier];
    }
    
    BOOL isEditing = self.editing;
    
    if (indexPath.section == LOCATIONINFO_SECTION) {
        [cell configureCell:self.location forAttribute:@"place" enable:isEditing forClass:@"Location"];            
    }
    
    if ([itemList count] > 0) {
        if (indexPath.section == ITEMLIST_SECTION) {
            Item *item = [itemList objectAtIndex:indexPath.row];
            defaultCell.textLabel.text = item.name;
            defaultCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return defaultCell;
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle editingStyle;
    
    switch (indexPath.section) {
        case LOCATIONINFO_SECTION:
            editingStyle = UITableViewCellEditingStyleNone;
            break;
        case ITEMLIST_SECTION:
            editingStyle = UITableViewCellEditingStyleDelete;
            break;
    }
    return editingStyle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Only Delete the vendor attribute, still save the item object. If need to delete the item, one has to go into the detail view and click delete button.
        if (!changedItems)
            changedItems = [[NSMutableArray alloc] init];
        
        Item *editingItem = [itemList objectAtIndex:indexPath.row];
        editingItem.company = nil;
        
        // Move the selected object into changedItem array
        [changedItems addObject:editingItem];
        [itemList removeObject:editingItem];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    } 
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ITEMLIST_SECTION) {
        Item *selectedItem = [itemList objectAtIndex:indexPath.row]; 
        
        ItemDetailViewController *detailViewController = [[ItemDetailViewController alloc] initWithItem:selectedItem];
        
        [detailViewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else
        return;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}


#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField 
{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.editing = NO;
	return YES;
}

@end
