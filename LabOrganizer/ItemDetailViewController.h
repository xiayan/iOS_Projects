//
//  ItemDetailViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemInfoTableViewController.h"
@class ItemSettingTableViewController;
@class Item;

@interface ItemDetailViewController : UITabBarController <ItemInfoDelegate> {
    
    ItemInfoTableViewController *itemInfoTableViewController;
    ItemSettingTableViewController *itemSettingTableViewController;
    Item *item;
}

@property (nonatomic, strong) ItemInfoTableViewController *itemInfoTableViewController; 
@property (nonatomic, strong) ItemSettingTableViewController *itemSettingTableViewController;
@property (nonatomic, strong) Item *item;

- (id)initWithItem:(Item *)newItem;
- (void)cancelChanges:(id)sender;

@end
