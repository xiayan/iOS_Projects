//
//  CompanyListTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/9/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyDetailTableViewController;

@interface CompanyListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    
    CompanyDetailTableViewController *companyDetailTableViewController;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) CompanyDetailTableViewController *companyDetailTableViewController;

@end
