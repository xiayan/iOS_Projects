//
//  MediaPlayerViewController.m
//  MediaPlayer
//
//  Created by Joe Conway on 6/30/10.
//  Copyright 2010 Big Nerd Ranch. All rights reserved.
//

#import "MediaPlayerViewController.h"


@implementation MediaPlayerViewController

- (id)init
{
	self = [super initWithNibName:@"MediaPlayerViewController" bundle:nil];

	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Sound12"
                                                          ofType:@"aif"];
    // If this file is actually in the bundle...
    if(soundPath) {
        // Create a file URL with this path
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    
        // Register sound file located at that URL as a system sound
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &shortSound);
		if(err != kAudioServicesNoError) 
			NSLog(@"Could not load %@, error code: %d", soundURL, err);
	}

    // Obtain full path in NSURL format to Music.mp3 
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"Layers" 
                                                          ofType:@"m4v"];
    if(moviePath) {
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        moviePlayer = [[MPMoviePlayerController alloc] 
                                initWithContentURL:movieURL];	
	}
	
	NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"Music"
                                                          ofType:@"mp3"];
    if(musicPath) {
        NSURL *musicURL = [NSURL fileURLWithPath:musicPath];	
		[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL 
                                                         error:nil];
		[audioPlayer setDelegate:self];
    }	
	
	return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	return [self init];
}
- (void)viewDidLoad
{
	[[self view] addSubview:[moviePlayer view]];
	float halfHeight = [[self view] bounds].size.height / 2.0;
	float width = [[self view] bounds].size.width;
	[[moviePlayer view] setFrame:CGRectMake(0, halfHeight, width, halfHeight)];
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player 
                       successfully:(BOOL)flag 
{ 
    [audioButton setTitle:@"Play Audio File" 
                 forState:UIControlStateNormal]; 
} 
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player 
{ 
    [audioPlayer play]; 
} 

- (IBAction)playAudioFile:(id)sender 
{ 
    if ([audioPlayer isPlaying]) { 
        // Stop playing audio and change text of button 
        [audioPlayer stop]; 
        [sender setTitle:@"Play Audio File" 
                forState:UIControlStateNormal]; 
    } 
    else { 
        // Start playing audio and change text of button so user can tap to stop playback 
        [audioPlayer play]; 
        [sender setTitle:@"Stop Audio File" 
                forState:UIControlStateNormal]; 
    } 
} 

- (IBAction)playShortSound:(id)sender 
{ 
    AudioServicesPlaySystemSound(shortSound); 
} 

- (void)dealloc {
	[audioPlayer release];
	[moviePlayer release];
	AudioServicesDisposeSystemSoundID(shortSound);
	[audioButton release];
    [super dealloc];
}


@end
