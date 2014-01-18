//
//  CompanySelectionViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/7/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class CompanyTableViewCell;

@interface CompanySelectionViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITextFieldDelegate> {
    Item *item;
    NSFetchedResultsController *fetchedResultsController;
    
    IBOutlet UIView *companySelectionHeaderView;
    IBOutlet UIView *companyCreationHeaderView;
    IBOutlet UITableView *headerTableView;
    IBOutlet CompanyTableViewCell *companyTableViewCell;
}

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIView *companySelectionHeaderView;
@property (nonatomic, strong) UIView *companyCreationHeaderView;
@property (nonatomic, strong) CompanyTableViewCell *companyTableViewCell;
@property (nonatomic, strong) UITableView *headerTableView;

- (id)initWithItem:(Item *)newItem;
- (void)createCompany:(id)sender;
- (void)cancelCompany:(id)sender;
- (IBAction)showSelectionHeaderView:(id)sender;
- (NSString *)headerTableTextAtRow:(NSUInteger)row;
- (void)clearHeaderTableViewText;

@end
