//
//  UITableViewCategory.m
//  LabOrganizer
//
//  Created by Yan Xia on 4/11/11.
//  Copyright 2011 the University of Kansas. All rights reserved.
//

#import "HelperCategories.h"
#import <QuartzCore/QuartzCore.h>

@implementation UITableView (Reload)

- (void)reloadData:(BOOL)animated {
	[self reloadData];
	if (animated) {
		CATransition *animation = [CATransition animation];
		[animation setType:kCATransitionFade];
		[animation setDuration:0.4];
		[animation setTimingFunction:[CAMediaTimingFunction
                                      functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[animation setFillMode: @"extended"];
		
		[[self layer] addAnimation:animation forKey:@"reloadAnimation"];
	}
}

- (void)setTableHeaderView:(UIView *)aTableHeaderView animated:(BOOL)animated
{
    self.tableHeaderView = aTableHeaderView;
    
    if (animated) {
		CATransition *animation = [CATransition animation];
		[animation setType:kCATransitionFade];
		[animation setDuration:0.4];
		[animation setTimingFunction:[CAMediaTimingFunction
                                      functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[animation setFillMode: @"extended"];
		
		[[self layer] addAnimation:animation forKey:@"reloadAnimation"];
	}
}

@end

@implementation UITableViewController (Email)
    
- (void)sendEmailToRecipient:(NSString *)recipent
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        if ([mailClass canSendMail]) {
            [self displayComposeSheetToRecipent:recipent];
        } else {
            [self launchMailAppOnDeviceToRecipient:recipent];
        }
    } else {
        [self launchMailAppOnDeviceToRecipient:recipent];
    }
}

- (void)displayComposeSheetToRecipent:(NSString *)recipent
{
    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] init];
    composeViewController.mailComposeDelegate = self;
    
    NSArray *toRecipients = [NSArray arrayWithObject:recipent];
    
    [composeViewController setToRecipients:toRecipients];
    
    [self presentModalViewController:composeViewController animated:YES];
    
    return;
}

- (void)launchMailAppOnDeviceToRecipient:(NSString *)recipient
{
    NSString *formattedRecipient = [NSString stringWithFormat:@"mailto:%@", recipient];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:formattedRecipient]];
    
    return;
}

# pragma mark - Mail Compose Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
}

# pragma mark - Lauching Safari
- (void)lauchSafariAppOnDeviceUsingString:(NSString *)aString
{
    NSString *url = nil;
    NSString *subString = nil;
    if ([aString length] >= 7) {
        subString = [aString substringWithRange:NSMakeRange(0, 6)];
        if ([subString isEqualToString:@"http://"]) {
            url = aString;
        } else {
            url = [NSString stringWithFormat:@"http://%@",aString];
        }
    } else {
        url = [NSString stringWithFormat:@"http://%@",aString];
    }
     
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    // To get rid of the selection when getting back to the app
    [self.tableView reloadData];
    
    return;
}

@end