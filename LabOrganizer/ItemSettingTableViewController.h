//
//  ItemSettingTableViewController.h
//  LabOrganizer
//
//  Created by Yan Xia on 3/29/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;

@interface ItemSettingTableViewController : UITableViewController {
    Item *item;
}

@property (nonatomic, strong) Item *item;

- (id)initWithItem:(Item *)newItem;
- (void)cancelChanges;

@end
