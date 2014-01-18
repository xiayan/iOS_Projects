//
//  UITableViewCategory.h
//  LabOrganizer
//
//  Created by Yan Xia on 4/11/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface UITableView (Reload) 

- (void)reloadData:(BOOL)animated;
- (void)setTableHeaderView:(UIView *)tableHeaderView animated:(BOOL)animated;

@end

@interface UITableViewController (Email) <MFMailComposeViewControllerDelegate>

- (void)sendEmailToRecipient:(NSString *)recipent;
- (void)displayComposeSheetToRecipent:(NSString *)recipent;
- (void)launchMailAppOnDeviceToRecipient:(NSString *)recipient;

- (void)lauchSafariAppOnDeviceUsingString:(NSString *)aString;

@end
