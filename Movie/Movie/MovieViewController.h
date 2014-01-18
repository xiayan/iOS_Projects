//
//  MovieViewController.h
//  Movie
//
//  Created by Yan Xia on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController : UIViewController

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)playMovie:(id)sender;

@end
