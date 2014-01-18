//
//  LabOrganizerAppDelegate.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/23/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemListTableViewController;
@class CompanyListTableViewController;
@class LocationListTableViewController;
@class CategoryListTableViewController;
@class ExpListTableViewController;

@interface LabOrganizerAppDelegate : NSObject <UIApplicationDelegate> {
    
    IBOutlet UITabBarController *tabBarController;
    IBOutlet ItemListTableViewController *itemListTableViewController;
    IBOutlet CompanyListTableViewController *companyListTableViewController;
    IBOutlet LocationListTableViewController *locationListTableViewController;
    IBOutlet CategoryListTableViewController *categoryListTableViewController;
    IBOutlet ExpListTableViewController *expListTableViewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
