//
//  ItemInfoTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ItemInfoDelegate;
@class Item;
@class ItemInfoHeaderViewController;
@class InfoTableViewCell;

@interface ItemInfoTableViewController : UITableViewController <UITextFieldDelegate> {
    Item *item;
    NSUndoManager *undoManager;

    ItemInfoHeaderViewController *itemInfoHeaderViewController;
    
    id <ItemInfoDelegate> __unsafe_unretained delegate;
 
    IBOutlet InfoTableViewCell *infoTableViewCell;
    IBOutlet UIView *itemFooterView;
    IBOutlet UIButton *deleteButton;
}

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) NSUndoManager *undoManager;
@property (nonatomic, strong) ItemInfoHeaderViewController *itemInfoHeaderViewController;
@property (nonatomic, strong) InfoTableViewCell *infoTableViewCell;
@property (nonatomic, strong) UIView *itemFooterView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, unsafe_unretained) id <ItemInfoDelegate> delegate;

- (id)initWithItem:(Item *)item;

- (IBAction)deleteItem:(id)sender;
- (void)saveChanges;
- (void)cancelChanges;
- (NSString *)textForRow:(NSUInteger)row inSection:(NSUInteger)section;

@end

// Disable Done button when creating new item.  Enable it with pre-existing items.
@protocol ItemInfoDelegate <NSObject>

- (void)enableDoneButton;

@end