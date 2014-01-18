//
//  ExpListTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/18/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExpListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;

@end

