//
//  AppDelegate.h
//  Quiz
//
//  Created by Yan Xia on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    int currentQuestionIndex;
    
    //Model
    NSMutableArray *questions;
    NSMutableArray *answers;
    
    //View
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
