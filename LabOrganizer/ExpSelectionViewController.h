//
//  ExpSelectionViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/18/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface ExpSelectionViewController : UITableViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate> {

    NSFetchedResultsController *fetchedResultsController;
    Item *item;
    
    IBOutlet UIView *expCreationHeaderView;
    IBOutlet UIView *expInputHeaderView;
    IBOutlet UITextField *textField;
}

@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong)Item *item;

- (id)initWithItem:(Item *)newItem;
- (IBAction)showInputHeaderView:(id)sender;

@end
