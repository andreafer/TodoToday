//
//  SoundListViewController.m
//  SystemSoundLibrary
//
//  Created by Anton Pauli on 12.10.13.
//  Copyright (c) 2013 Anton Pauli. All rights reserved.
//

#import "SoundListViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface SoundListViewController ()

@end

@implementation SoundListViewController



NSArray *pAlarmSounds = nil;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAudioFileList];
}

-(void)loadAudioFileList{
    pAlarmSounds = [NSArray arrayWithObjects:
                     @"Beep-SoundBible.wav",
                     @"Bleep-SoundBible.wav",
                     @"Car Door Open And Alarm-SoundBible.wav",
                     @"Computer_Magic-Microsift.wav",
                     @"Metronome-SoundBible.wav",
                     @"Realistic_Punch-Mark_DiAngelo.wav",
                     @"Temple Bell-SoundBible.wav",
                     @"Woosh-Mark_DiAngelo.wav",
                     nil];
    
    audioFileList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [pAlarmSounds count]; i++) {
        [audioFileList addObject:[pAlarmSounds objectAtIndex:i]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [audioFileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[audioFileList objectAtIndex:indexPath.row] lastPathComponent];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSError* error;
    [[AVAudioSession sharedInstance]
     setCategory:AVAudioSessionCategoryPlayAndRecord
     error:&error];
    
    if (error == nil)
    {
        NSString *szResource = [pAlarmSounds objectAtIndex:indexPath.row];
        NSString *fileName = [[NSBundle mainBundle] pathForResource:[szResource stringByDeletingPathExtension] ofType:@"wav"];
        NSURL *url = [[NSURL alloc] initFileURLWithPath:fileName];
        NSLog(@"Test: %@ ", url);
        
        _theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
        _soundName = szResource;
        [_theAudio play];
    }
}

@end
