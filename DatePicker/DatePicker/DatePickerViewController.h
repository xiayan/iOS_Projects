//
//  DatePickerViewController.h
//  DatePicker
//
//  Created by Yan Xia on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong ,nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)getSelection:(id)sender;

@end
