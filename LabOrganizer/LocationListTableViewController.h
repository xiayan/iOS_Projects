//
//  LocationListTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LocationListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;

@end
