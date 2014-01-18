//
//  ItemDetailViewController.m
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Item.h"
#import "ItemSettingTableViewController.h"

@implementation ItemDetailViewController
@synthesize itemInfoTableViewController;
@synthesize itemSettingTableViewController;
@synthesize item;

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
    self = [super initWithNibName:nil bundle:nil];
    self.item = newItem;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = self.item.name;
    
    self.itemInfoTableViewController = [[ItemInfoTableViewController alloc] initWithItem:self.item];
    self.itemSettingTableViewController = [[ItemSettingTableViewController alloc] initWithItem:self.item];
    
    itemInfoTableViewController.delegate = self;
    
    itemInfoTableViewController.title = @"Info";
    itemSettingTableViewController.title = @"Setting";
    
    NSArray *viewControllers = [NSArray arrayWithObjects:itemInfoTableViewController, itemSettingTableViewController, nil];
    
    [self setViewControllers:viewControllers];

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
    
    [itemInfoTableViewController setEditing:editing animated:animated];
    
    if (!editing) {
        // Get rid of the cancel button when not editing
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.title = self.item.name;
        
        NSManagedObjectContext *context = self.item.managedObjectContext;
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else {
        // When editing, put a cancel button so that the changes can be omitted
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelChanges:)];
        self.navigationItem.leftBarButtonItem = leftButton;
    }
}

- (void)cancelChanges:(id)sender
{
    UITableViewController *topController = (UITableViewController *)self.selectedViewController;
    
    if ([topController class] == [ItemInfoTableViewController class]) {
        [self.itemInfoTableViewController cancelChanges];
    } else if ([topController class] == [ItemSettingTableViewController class]) {
        [self.itemSettingTableViewController cancelChanges];
    }
    
    self.editing = NO;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Auto Rotations

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    duration = 0.1;
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{
    duration = 0.1;
}

#pragma mark - ItemInfo Delegate

- (void)enableDoneButton
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

@end
