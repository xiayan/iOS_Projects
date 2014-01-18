//
//  ItemInfoHeaderViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/30/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@class ItemHeaderTableViewCell;

@interface ItemInfoHeaderViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    Item *item;
    NSUndoManager *undoManager;
    
    IBOutlet UIView *pickerViewContainer;
    
    IBOutlet UITableView *infoTableView;
    
    IBOutlet UIView *infoView;
    IBOutlet UILabel *nameLabel;
    
    IBOutlet ItemHeaderTableViewCell *itemHeaderTableViewCell;
}

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) NSUndoManager *undoManager;
@property (nonatomic, strong) UIView *pickerViewContainer;
@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) ItemHeaderTableViewCell *itemHeaderTableViewCell;

- (id)initWithItem:(Item *)newItem;
- (IBAction)ordered:(id)sender;
- (void)saveChanges;
- (void)cancelChanges;

@end
