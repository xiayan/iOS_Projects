//
//  CoreDataViewController.m
//  CoreData
//
//  Created by Yan Xia on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CoreDataViewController.h"
#import "CoreDataAppDelegate.h"

@implementation CoreDataViewController
@synthesize name, address, phone, status;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.name = nil;
    self.address = nil;
    self.phone = nil;
    self.status = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions
- (void)saveData:(id)sender
{
    CoreDataAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
    [newContact setValue:self.name.text forKey:@"name"];
    [newContact setValue:self.address.text forKey:@"address"];
    [newContact setValue:self.phone.text forKey:@"phone"];
    self.name.text = @"";
    self.address.text = @"";
    self.phone.text = @"";
    NSError *error = [[NSError alloc] init];
    [context save:&error];
    self.status.text = @"Contact Saved";
}

- (void)findContact:(id)sender
{
    CoreDataAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Contacts"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@", self.name.text];
    [request setPredicate:pred];
    NSManagedObject *match = nil;
    NSError *error;
    NSArray *matchedObjects = [context executeFetchRequest:request error:&error];
    if ([matchedObjects count] == 0) {
        self.status.text = @"No Mathces";
    } else {
        match = [matchedObjects objectAtIndex:0];
        self.name.text = [match valueForKey:@"name"];
        self.address.text = [match valueForKey:@"address"];
        self.phone.text = [match valueForKey:@"phone"];
        self.status.text = [NSString stringWithFormat:@"%i matches found", [matchedObjects count]];
    }
}

@end
