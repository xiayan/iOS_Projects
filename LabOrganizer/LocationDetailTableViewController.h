//
//  LocationDetailTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/13/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyTableViewCell;

@interface LocationDetailTableViewController : UITableViewController <UITextFieldDelegate> {
    NSManagedObject *location;
    NSMutableArray *itemList;
    NSSortDescriptor *sortDescriptor;
    NSUndoManager *undoManager;
    
    IBOutlet UIView *locationFooterView;
    IBOutlet CompanyTableViewCell *companyTableViewCell;
}

@property (nonatomic, strong) NSManagedObject *location;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) UIView *locationFooterView;
@property (nonatomic, strong) CompanyTableViewCell *companyTableViewCell;

- (id)initWithLocation:(NSManagedObject *)newLocation;
- (IBAction)deleteLocation:(id)sender;
- (void)saveChanges;
- (NSString *)textForRow:(NSUInteger)row;
- (void)cancelChanges:(id)sender;

@end
