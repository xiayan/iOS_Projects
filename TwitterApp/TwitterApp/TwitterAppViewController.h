//
//  TwitterAppViewController.h
//  TwitterApp
//
//  Created by Yan Xia on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/TWTweetComposeViewController.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface TwitterAppViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *tweetURL;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) TWTweetComposeViewController *tweetView;

- (IBAction)previewTweet:(id)sender;
- (IBAction)selectImage:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@end
