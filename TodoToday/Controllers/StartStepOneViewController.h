//
//  StartStepOneViewController.h
//  TodoToday
//
//  Created by HongYun on 3/5/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface StartStepOneViewController : SuperViewController
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *radioOne;
@property (weak, nonatomic) IBOutlet UIButton *radioTwo;
@property (weak, nonatomic) IBOutlet UIButton *radioThree;
@property (weak, nonatomic) IBOutlet UIButton *radioFour;
@property (weak, nonatomic) IBOutlet UIButton *radioFive;
@property (weak, nonatomic) IBOutlet UIButton *chkMonday;
@property (weak, nonatomic) IBOutlet UIButton *chkTuesday;
@property (weak, nonatomic) IBOutlet UIButton *chkWednesday;
@property (weak, nonatomic) IBOutlet UIButton *chkThursday;
@property (weak, nonatomic) IBOutlet UIButton *chkFriday;
@property (weak, nonatomic) IBOutlet UIButton *chkSaturday;
@property (weak, nonatomic) IBOutlet UIButton *chkSunday;

- (IBAction)onOneButton:(id)sender;
- (IBAction)onTwoButton:(id)sender;
- (IBAction)onThreeButton:(id)sender;
- (IBAction)onFourButton:(id)sender;
- (IBAction)onFiveButton:(id)sender;
- (IBAction)onMondayButton:(id)sender;
- (IBAction)onTuesdayButton:(id)sender;
- (IBAction)onWednesdayButton:(id)sender;
- (IBAction)onThursdayButton:(id)sender;
- (IBAction)onFridayButton:(id)sender;
- (IBAction)onSaturdayButton:(id)sender;
- (IBAction)onSundayButton:(id)sender;
- (IBAction)onNextButton:(id)sender;

@end