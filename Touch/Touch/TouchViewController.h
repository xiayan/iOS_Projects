//
//  TouchViewController.h
//  Touch
//
//  Created by Yan Xia on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *touchStatus;
@property (strong, nonatomic) IBOutlet UILabel *methodStatus;
@property (strong, nonatomic) IBOutlet UILabel *tapStatus;
@property (strong, nonatomic) IBOutlet UILabel *xCoordinate;
@property (strong, nonatomic) IBOutlet UILabel *yCoordinate;

@end
