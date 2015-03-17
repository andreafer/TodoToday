//
//  SoundListViewController.h
//  SystemSoundLibrary
//
//  Created by Anton Pauli on 12.10.13.
//  Copyright (c) 2013 Anton Pauli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "SuperViewController.h"

@interface SoundListViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *audioFileList;
}

@property (nonatomic) NSString *soundName;
@property (nonatomic, retain) AVAudioPlayer *theAudio;

@end
