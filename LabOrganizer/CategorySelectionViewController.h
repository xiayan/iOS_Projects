//
//  CategorySelectionViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/17/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface CategorySelectionViewController : UITableViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate> {
    
    NSFetchedResultsController *fetchedResultsController;
    Item *item;
    
    IBOutlet UIView *categoryCreationHeaderView;
    IBOutlet UIView *categoryInputHeaderView;
    IBOutlet UITextField *textField;
}

@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong)Item *item;

- (id)initWithItem:(Item *)newItem;
- (IBAction)showInputHeaderView:(id)sender;

@end
