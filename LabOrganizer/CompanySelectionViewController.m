//
//  CompanySelectionViewController.m
//  LabOrganizer
//
//  Created by Yan Xia on 4/7/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "CompanySelectionViewController.h"
#import "Item.h"
#import "HelperCategories.h"
#import "CompanyTableViewCell.h"

@implementation CompanySelectionViewController
@synthesize item, fetchedResultsController;
@synthesize companySelectionHeaderView;
@synthesize companyCreationHeaderView;
@synthesize companyTableViewCell;
@synthesize headerTableView;

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

- (id)initWithItem:(Item *)newItem
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.item = newItem;
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

    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    if (!companyCreationHeaderView) {
        [[NSBundle mainBundle] loadNibNamed:@"CompanySelectionHeaderView" owner:self options:nil];
    }
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
    NSInteger number = [sectionInfo numberOfObjects];
    
    if (number > 0) {
        self.tableView.tableHeaderView = self.companyCreationHeaderView;
    } else {
        [self showSelectionHeaderView:nil];
    }

    headerTableView.allowsSelection = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.companySelectionHeaderView = nil;
    self.companyCreationHeaderView = nil;
    //textField = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.tableView.tableHeaderView == self.companySelectionHeaderView) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        CompanyTableViewCell *cell = (CompanyTableViewCell *)[headerTableView cellForRowAtIndexPath:indexPath];
        [cell.textField becomeFirstResponder];
    }

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Methods

- (IBAction)showSelectionHeaderView:(id)sender
{
    [self.tableView setTableHeaderView:self.companySelectionHeaderView animated:YES];
    // Get rid of the input from previous session. 
    [headerTableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CompanyTableViewCell *cell = (CompanyTableViewCell *)[headerTableView cellForRowAtIndexPath:indexPath];
    [cell.textField becomeFirstResponder];
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStylePlain target:self action:@selector(createCompany:)];
    self.navigationItem.rightBarButtonItem = createButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCompany:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)createCompany:(id)sender;
{
    NSString *companyName = [self headerTableTextAtRow:0];
    NSString *companyPhone = [self headerTableTextAtRow:1];
    NSString *companyEmail = [self headerTableTextAtRow:2];
    NSString *companyWebsite = [self headerTableTextAtRow:3];
    
    NSManagedObject *newCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.item.managedObjectContext];
    
    [newCompany setValue:companyName forKey:@"companyName"];
    [newCompany setValue:companyPhone forKey:@"companyPhone"];
    [newCompany setValue:companyEmail forKey:@"companyEmail"];
    [newCompany setValue:companyWebsite forKey:@"companyWebsite"]; 

    
    self.item.company = newCompany;
    
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];

    
    [self.tableView setTableHeaderView:self.companyCreationHeaderView animated:YES];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)cancelCompany:(id)sender
{   
    // Delete all the text in the table view, so that it won't get registered by 'textfieldShouldEndEditing'
    [self clearHeaderTableViewText];
    
    [headerTableView resignFirstResponder];

    [self.tableView setTableHeaderView:self.companyCreationHeaderView animated:YES];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (NSString *)headerTableTextAtRow:(NSUInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    CompanyTableViewCell *cell = (CompanyTableViewCell *)[headerTableView cellForRowAtIndexPath:indexPath];
    
    return cell.textField.text;
}

- (void)clearHeaderTableViewText
{
    int row;
    for (row = 0; row < 4; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        CompanyTableViewCell *cell = (CompanyTableViewCell *)[headerTableView cellForRowAtIndexPath:indexPath];
        cell.textField.text = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger numberOfSections = 1;
    return numberOfSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    if (tableView == self.tableView) {
        title = @"Existing Vendors";
    } else if (tableView == headerTableView) {
        title = @"New Vendor";
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numberOfRows = 0;

    if (tableView == self.tableView) {
        if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
        }
    } else if (tableView == headerTableView) {
        numberOfRows = 4;
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *EditingCellIdentifier = @"EditingCellIdentifier";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    CompanyTableViewCell *editingCell = (CompanyTableViewCell *)[headerTableView dequeueReusableCellWithIdentifier:EditingCellIdentifier];
    if (editingCell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CompanySelectionTableViewCell" owner:self options:nil];
        editingCell = self.companyTableViewCell;
        self.companyTableViewCell = nil;
    }
    editingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    if (tableView == self.tableView) {
        NSManagedObject *company = [fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [company valueForKey:@"companyName"];
        cell.detailTextLabel.text = [company valueForKey:@"companyWebsite"];
    
        if (company == self.item.company)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if (tableView == headerTableView) {
        switch (indexPath.row) {
            case 0:
                editingCell.label.text = @"Vendor";
                editingCell.textField.text = nil;
                return editingCell;
            case 1:
                editingCell.label.text = @"Phone";
                editingCell.textField.text = nil;
                return editingCell;
            case 2:
                editingCell.label.text = @"Email";
                editingCell.textField.text = nil;
                return editingCell;
            case 3:
                editingCell.label.text = @"URL";
                editingCell.textField.text = nil;
                return editingCell;
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If there was a previous selection, unset the accessory view for its cell.
	NSManagedObject *currentCompany = self.item.company;
	
    if (currentCompany != nil) {
		NSIndexPath *index = [fetchedResultsController indexPathForObject:currentCompany];
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:index];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Set the checkmark accessory for the selected row.
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    // Update the type of the recipe instance
    self.item.company = [fetchedResultsController objectAtIndexPath:indexPath];
    
    // Deselect the row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fetched Result Controller
- (NSFetchedResultsController *)fetchedResultsController
{
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.item.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"companyName" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.item.managedObjectContext sectionNameKeyPath:nil cacheName:@"Companies"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
    }
	
	return fetchedResultsController;
}

#pragma  mark - FetchedResultController Delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
	switch(type) {
			
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
            cell.textLabel.text = [item.company valueForKey:@"companyName"];
            // Make the item name show if its positiion doesn't need to change
            [tableView reloadData];
            break;
            
        case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
}

# pragma mark - Text Field Delegate

/*
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    CompanyTableViewCell *cell = (CompanyTableViewCell *) [[textField superview] superview];
    NSString *text = cell.label.text;
    NSString *value = cell.textField.text;
    
    if (![value isEqualToString:@""]){
        if (text == @"Vendor") {
            [self.item.company setValue:value forKey:@"companyName"];
        } else if (text == @"Phone") {
            [self.item.company setValue:value forKey:@"companyPhone"];
        } else if (text == @"Email") {
            [self.item.company setValue:value forKey:@"companyEmail"];
        } else if (text == @"URL") {
            [self.item.company setValue:value forKey:@"companyWebsite"];
        }
    }
    
    return YES;
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
    [self createCompany:nil];

    return YES;
}

@end
