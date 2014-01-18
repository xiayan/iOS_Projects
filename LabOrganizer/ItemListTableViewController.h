//
//  ItemListTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemDetailViewController;

@interface ItemListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> 
{
    NSManagedObjectContext *managedObjectContex;    
    NSFetchedResultsController *fetchedResultsController;
    
    ItemDetailViewController *itemDetailViewController;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) ItemDetailViewController *itemDetailViewController;

@end
