//
//  DBViewController.h
//  DB
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

@interface DBViewController : UIViewController
{
    sqlite3 *contactDB;
    
    UITextField *name;
    UITextField *address;
    UITextField *phone;
    UILabel *status;
    NSString *databasePath;
}

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) NSString *databasePath;

- (IBAction)saveData:(id)sender;
- (IBAction)findContact:(id)sender;

@end
