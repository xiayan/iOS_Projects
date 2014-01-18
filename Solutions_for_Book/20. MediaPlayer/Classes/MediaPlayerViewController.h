//
//  MediaPlayerViewController.h
//  MediaPlayer
//
//  Created by Joe Conway on 6/30/10.
//  Copyright 2010 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h> 
#import <AVFoundation/AVFoundation.h> 
#import <MediaPlayer/MediaPlayer.h> 


@interface MediaPlayerViewController : UIViewController <AVAudioPlayerDelegate>
{
	AVAudioPlayer *audioPlayer; 
	MPMoviePlayerController *moviePlayer; 
	SystemSoundID shortSound; 

	IBOutlet UIButton *audioButton; 
}
- (IBAction)playAudioFile:(id)sender; 
- (IBAction)playShortSound:(id)sender; 
@end
