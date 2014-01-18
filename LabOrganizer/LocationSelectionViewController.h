//
//  LocationSelectionViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/13/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface LocationSelectionViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITextFieldDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    Item *item;
    
    IBOutlet UIView *locationCreationHeaderView;
    IBOutlet UIView *locationInputHeaderView;
    IBOutlet UITextField *textField;
}

@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong)Item *item;

- (id)initWithItem:(Item *)newItem;
- (IBAction)showInputHeaderView:(id)sender;

@end
