//
//  AudioViewController.h
//  Audio
//
//  Created by Yan Xia on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioViewController : UIViewController <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UISlider *volumeControl;

- (IBAction)playAudio:(id)sender;
- (IBAction)stopAudio:(id)sender;
- (IBAction)adjustVolume:(id)sender;

@end
