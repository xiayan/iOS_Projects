//
//  FileExampleViewController.h
//  FileExample
//
//  Created by Yan Xia on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileExampleViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textBox;

- (IBAction)saveText:(id)sender;
- (IBAction)textReturn:(id)sender;

@end
