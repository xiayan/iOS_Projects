//
//  RootViewController.h
//  TableView
//
//  Created by Yan Xia on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookViewController;

@interface RootViewController : UITableViewController

@property (strong, nonatomic) NSArray *authorList;
@property (strong, nonatomic) IBOutlet BookViewController *booksController;

@end
