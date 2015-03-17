//
//  StartStepThreeViewController.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#include <UIKit/UIKit.h>
#include "SuperViewController.h"

@import MediaPlayer;

@interface StartStepThreeViewController : SuperViewController <MPMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnAlertSound;
@property (weak, nonatomic) IBOutlet UITextField *txtSoundName;

- (IBAction)onSoundPicked:(UIStoryboardSegue *)segue;

@end