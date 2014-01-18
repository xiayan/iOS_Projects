//
//  ArchiveViewController.h
//  Archive
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
@interface ArchiveViewController : UIViewController
{
    Person *aPerson;
}

@property (strong, nonatomic) Person *aPerson;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) NSString *dataFilePath;

- (IBAction)saveData:(id)sender;

@end
