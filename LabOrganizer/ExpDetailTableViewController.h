//
//  ExpDetailTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/18/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyTableViewCell;

@interface ExpDetailTableViewController : UITableViewController {
    NSManagedObject *experiment;
    NSMutableArray *itemList;
    NSSortDescriptor *sortDescriptor;
    NSUndoManager *undoManager;
    
    IBOutlet UIView *expFooterView;
    IBOutlet CompanyTableViewCell *companyTableViewCell;
}

@property (nonatomic, strong) NSManagedObject *experiment;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) UIView *expFooterView;
@property (nonatomic, strong) CompanyTableViewCell *companyTableViewCell;

- (id)initWithExperiment:(NSManagedObject *)newExperiment;
- (IBAction)deleteExperiment:(id)sender;
- (void)saveChanges;
- (NSString *)textForRow:(NSUInteger)row;
- (void)cancelChanges:(id)sender;

@end
