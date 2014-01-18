//
//  ItemInfoTableViewController.m
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "ItemInfoTableViewController.h"
#import "Item.h"
#import "Person.h"
#import "Company.h"
#import "ItemInfoHeaderViewController.h"
#import "InfoTableViewCell.h"
#import "CompanySelectionViewController.h"
#import "CompanyDetailTableViewController.h"
#import "LocationSelectionViewController.h"
#import "LocationDetailTableViewController.h"
#import "CategorySelectionViewController.h"
#import "CategoryDetailTableViewController.h"
#import "ExpSelectionViewController.h"
#import "ExpDetailTableViewController.h"
#import "HelperCategories.h"

@implementation ItemInfoTableViewController
@synthesize item;
@synthesize undoManager;
@synthesize itemInfoHeaderViewController;
@synthesize infoTableViewCell;
@synthesize itemFooterView, deleteButton;
@synthesize delegate;

static BOOL cancel;

#define COMPANY_SECTION 0
#define ITEMINFO_SECTION 1
#define PERSON_SECTION 2
#define OTHER_SECTION 3

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    return self;
}
*/

- (id)initWithItem:(Item *)newItem
{
    self = [super initWithStyle:UITableViewStyleGrouped];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.itemInfoHeaderViewController setEditing:editing animated:animated];

    // Only show Delete button with exsiting item.  When creating a new item, don't need to show delete button
    // After creating a new item, when the name is empty, need to give it a placeholder name, like "untitled item"
    if (editing) {
        // Start undo grouping
        [undoManager beginUndoGrouping];
        
        self.tableView.tableFooterView = itemFooterView;
    } else {
        self.tableView.tableFooterView = nil;
        
        if (cancel) {
            [undoManager endUndoGrouping];
            NSManagedObjectContext *moc = self.item.managedObjectContext;
            [moc rollback];
            [undoManager removeAllActions];
            cancel = NO;
        } else {
            [undoManager removeAllActions];
            [self saveChanges];   
        }
    }

    [self.tableView reloadData:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    if (self.itemInfoHeaderViewController == nil) {
        itemInfoHeaderViewController = [[ItemInfoHeaderViewController alloc] initWithItem:self.item];
        self.tableView.tableHeaderView = self.itemInfoHeaderViewController.view;
    }
    
    if (itemFooterView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ItemFooterView" owner:self options:nil];
    }
    
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)viewDidUnload
{
    self.infoTableViewCell = nil;
    self.itemFooterView = nil;
    self.deleteButton = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    cancel = NO;
    [self.tableView reloadData];

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Methods

- (IBAction)deleteItem:(id)sender
{
    NSManagedObjectContext *context = self.item.managedObjectContext;
    
    [context deleteObject:self.item];
    
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
    self.item.catalog = [self textForRow:0 inSection:1];
    self.item.webpage = [self textForRow:1 inSection:1];
}

- (NSString *)textForRow:(NSUInteger)row inSection:(NSUInteger)section
{
    NSString *text = nil;
    /*
    if (self.editing) {
        InfoTableViewCell *cell = (InfoTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        text = cell.textField.text;
    } else {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        text = cell.detailTextLabel.text;
    }
    */
    
    InfoTableViewCell *cell = (InfoTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    text = cell.textField.text;

    return text;
}

- (void)cancelChanges
{   
    cancel = YES;
    [self.itemInfoHeaderViewController cancelChanges];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    switch (section) {
        case COMPANY_SECTION:
            title = @"Vendor Info";
            break;
        case ITEMINFO_SECTION:
            title = @"Item Details";
            break;
        case PERSON_SECTION:
            title = @"Person In Charge";
            break;
        case OTHER_SECTION:
            title = @"Other Info";
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numberOfSections = 3;
    
    if (section == COMPANY_SECTION) {
        if (self.item.company == nil) {
            numberOfSections = 1;
        } else {
            numberOfSections = 4;
        }
    }
    
    //if (section == COMPANY_SECTION)
      //  numberOfSections = 4;
    
    return numberOfSections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *InfoCellIdentifier = @"InfoTableViewCell";
    static NSString *DefaultCellIdentifier = @"DefaultCellIdentifier";
    
    InfoTableViewCell *cell = (InfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:InfoCellIdentifier];
    UITableViewCell *defaultCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    defaultCell.accessoryType = UITableViewCellAccessoryNone;
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil];
        cell = infoTableViewCell;
        self.infoTableViewCell = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (defaultCell == nil) {
        defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:DefaultCellIdentifier];
        defaultCell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        defaultCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    BOOL isEditing = self.editing;
    NSString *text = nil;
    
    if (indexPath.section == COMPANY_SECTION) {
        if (isEditing) {
            switch (indexPath.row) {
                case 0:
                    defaultCell.textLabel.text = @"Vendor";
                    text = [self.item.company valueForKey:@"companyName"];
                    break;
                case 1:
                    cell.label.text = @"V Phone";
                    cell.textField.text = [self.item.company valueForKey:@"companyPhone"];
                    return cell;
                case 2:
                    cell.label.text = @"V Email";
                    cell.textField.text = [self.item.company valueForKey:@"companyEmail"];
                    return cell;
                case 3:
                    cell.label.text = @"V URL";
                    cell.textField.text = [self.item.company valueForKey:@"companyWebsite"];
                    return cell;
            }
        } else {
                switch (indexPath.row) {
                    case 0:
                        defaultCell.textLabel.text = @"Vendor";
                        text = [self.item.company valueForKey:@"companyName"];
                        defaultCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                        break;
                    case 1:
                        defaultCell.textLabel.text = @"V Phone";
                        text = [self.item.company valueForKey:@"companyPhone"];
                        defaultCell.accessoryType = UITableViewCellAccessoryNone;
                        break;
                    case 2:
                        defaultCell.textLabel.text = @"V Email";
                        text = [self.item.company valueForKey:@"companyEmail"];
                        defaultCell.accessoryType = UITableViewCellAccessoryNone;
                        break;
                    case 3:
                        defaultCell.textLabel.text = @"V URL";
                        text = [self.item.company valueForKey:@"companyWebsite"];
                        defaultCell.accessoryType = UITableViewCellAccessoryNone;
                        break;
                }
            }
    }
    
    if (indexPath.section == ITEMINFO_SECTION) {
        if (isEditing) {
            switch (indexPath.row) {
                case 0:
                    cell.label.text = @"Catalog";
                    cell.textField.text = self.item.catalog;
                    return cell;
                case 1:
                    cell.label.text = @"URL";
                    cell.textField.text = self.item.webpage;
                    return cell;
                case 2:
                    defaultCell.textLabel.text = @"Note";
                    break;
            } 
        } else {
            switch (indexPath.row) {
                case 0:
                    defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    defaultCell.textLabel.text = @"Catalog";
                    text = self.item.catalog;
                    break;
                case 1:
                    defaultCell.textLabel.text = @"URL";
                    text = self.item.webpage;
                    defaultCell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 2:
                    defaultCell.textLabel.text = @"Note";
                    defaultCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
        }
    }
    
    if (indexPath.section == PERSON_SECTION) {
        if (isEditing) {
            switch (indexPath.row) {
                case 0:
                    defaultCell.textLabel.text = @"Person";
                    text = [(Person *)item.person fullName];
                    break;
                case 1:
                    if (self.item.company == nil)
                        cell.textField.enabled = NO;
                    cell.label.text = @"Phone";
                    cell.textField.text = self.item.person.personPhone;
                    return cell;
                case 2:
                    if (self.item.company == nil)
                        cell.textField.enabled = NO;
                    cell.label.text = @"Email";
                    cell.textField.text = self.item.person.email;
                    return cell;
            }
        } else {
            switch (indexPath.row) {
                case 0:
                    defaultCell.textLabel.text = @"Person";
                    text = [(Person *)item.person fullName];
                    defaultCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                    break;
                case 1:
                    defaultCell.textLabel.text = @"Phone";
                    text = self.item.person.personPhone;
                    defaultCell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 2:
                    defaultCell.textLabel.text = @"Email";
                    text = self.item.person.email;
                    defaultCell.accessoryType = UITableViewCellAccessoryNone;
                    break;
            }
        }
    }
    
    if (indexPath.section == OTHER_SECTION) {
        switch (indexPath.row) {
            case 0:
                defaultCell.textLabel.text = @"Location";
                text = [self.item.location valueForKey:@"place"];
                defaultCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case 1:
                defaultCell.textLabel.text = @"Category";
                text = [self.item.category valueForKey:@"reagentType"];
                defaultCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case 2:
                defaultCell.textLabel.text = @"Experiment";
                text = [self.item.experiment valueForKey:@"experimentType"];
                defaultCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
        }
    }
    
    defaultCell.detailTextLabel.text = text;
    
    return defaultCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    BOOL isEditing = self.editing;
    id detailedViewController = nil;
    
    if (!isEditing) {
        if (indexPath.section == COMPANY_SECTION) {
            switch (indexPath.row) {
                case 0:
                    detailedViewController = [[CompanyDetailTableViewController alloc] initWithVendor:(Company *)self.item.company];
                    break;
                default:
                    return;
            }
        } else if (indexPath.section == PERSON_SECTION) {
            return;
        } else if (indexPath.section == OTHER_SECTION) {
            switch (indexPath.row) {
                case 0:
                    detailedViewController = [[LocationDetailTableViewController alloc] initWithLocation:self.item.location];
                    break;
                case 1:
                    detailedViewController = [[CategoryDetailTableViewController alloc] initWithCategory:self.item.category];
                    break;
                case 2:
                    detailedViewController = [[ExpDetailTableViewController alloc] initWithExperiment:self.item.experiment];
                    break;
                default:
                    return;
            }
        }
    }
    
    if (detailedViewController) {
        [self.navigationController pushViewController:detailedViewController animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isEditing = self.editing;
    
    id detailedViewController = nil;
    
    if (indexPath.section == COMPANY_SECTION)
    {
        if (isEditing) {
            switch (indexPath.row) {
                case 0:
                    detailedViewController = [[CompanySelectionViewController alloc] initWithItem:self.item];
                    break;
                default:
                    return;
            }
        } else {
            switch (indexPath.row) {
                case 2:
                    [self sendEmailToRecipient:[self.item.company valueForKey:@"companyEmail"]];
                    return;
                case 3:
                    [self lauchSafariAppOnDeviceUsingString:[self.item.company valueForKey:@"companyWebsite"]];
                    return;
                default:
                    return;
            }
        }
    }
    
    if (indexPath.section == ITEMINFO_SECTION)
    {
        if (!isEditing) {
            switch (indexPath.row) {
                case 1:
                    [self lauchSafariAppOnDeviceUsingString:self.item.webpage];
                    
                default:
                    break;
            }
        }
    }
    
    if (indexPath.section == OTHER_SECTION)
    {
        if (isEditing) {
            switch (indexPath.row) {
                case 0:
                    detailedViewController = [[LocationSelectionViewController alloc] initWithItem:self.item];
                    break;
                case 1:
                    detailedViewController = [[CategorySelectionViewController alloc] initWithItem:self.item];
                    break;
                case 2:
                    detailedViewController = [[ExpSelectionViewController alloc] initWithItem:self.item];
                    break;
                default:
                    return;
            }
        } else
            return;
    }
    
    if (detailedViewController) {
        [self.navigationController pushViewController:detailedViewController animated:YES];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
	return YES;
}

@end
