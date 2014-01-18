//
//  CompanyDetailTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/10/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Company;
@class CompanyTableViewCell;

@interface CompanyDetailTableViewController : UITableViewController <UITextFieldDelegate> {
    
    Company *vendor;
    NSMutableArray *itemList;
    NSSortDescriptor *sortDescriptor;
    NSUndoManager *undoManager;
    
    IBOutlet UIView *companyFooterView;
    IBOutlet CompanyTableViewCell *companyTableViewCell;
}

@property (nonatomic, strong) Company *vendor;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) UIView *companyFooterView;
@property (nonatomic, strong) CompanyTableViewCell *companyTableViewCell;
@property (nonatomic, strong) NSUndoManager *undoManager;

- (id)initWithVendor:(Company *)newVendor;
- (IBAction)deleteVendor:(id)sender;
- (void)saveChanges;
- (NSString *)textForRow:(NSUInteger)row forSection:(NSUInteger)section;

@end
