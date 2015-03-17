//
//  StartStepThreeViewController.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "StartStepThreeViewController.h"
#import "TodoDateReminder.h"
#import "AppDelegate.h"
#import "Common.h"
#import "Config.h"
#import "SoundListViewController.h"

@implementation StartStepThreeViewController

- (void)viewDidLoad
{
    _txtSoundName.enabled = NO;
    _txtSoundName.text = [Common getAlarmSound];
    [super viewDidLoad];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueFromStep3Complete"])
    {
        [Common setAlarmSound:_txtSoundName.text];
        [[[TodoDateReminder alloc] init] updateReminders];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"everLaunched"];
    }
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (IBAction)onSoundPicked:(UIStoryboardSegue *)segue
{
    SoundListViewController *soundViewController = (SoundListViewController*)segue.sourceViewController;
    _txtSoundName.text = soundViewController.soundName;
}
@end
