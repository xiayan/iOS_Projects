//
//  CategoryDetailTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/18/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyTableViewCell;

@interface CategoryDetailTableViewController : UITableViewController <UITextFieldDelegate> {
    NSManagedObject *category;
    NSMutableArray *itemList;
    NSSortDescriptor *sortDescriptor;
    NSUndoManager *undoManager;
    
    IBOutlet UIView *categoryFooterView;
    IBOutlet CompanyTableViewCell *companyTableViewCell;
}

@property (nonatomic, strong) NSManagedObject *category;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) UIView *categoryFooterView;
@property (nonatomic, strong) CompanyTableViewCell *companyTableViewCell;

- (id)initWithCategory:(NSManagedObject *)newCategory;
- (IBAction)deleteCategory:(id)sender;
- (void)saveChanges;
- (NSString *)textForRow:(NSUInteger)row;
- (void)cancelChanges:(id)sender;

@end