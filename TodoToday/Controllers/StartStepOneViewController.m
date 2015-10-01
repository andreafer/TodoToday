//
//  StartStepOneViewController.m
//  TodoToday
//
//  Created by HongYun on 3/5/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "StartStepOneViewController.h"
#import "StartStepTwoViewController.h"
#import "Common.h"
#import "ConstString.h"
#import "Macros.h"
#import "Toast+UIView.h"
#import "Config.h"

@implementation StartStepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

///////////////////////////////////////////////
#pragma mark - Navigation Control

///////////////////////////////////////////////

int nMaxGoals;
#pragma mark - Basic Function
- (void) initControls {
    nMaxGoals = [Common getMaxGoals];
    switch( nMaxGoals )
    {
        case 2:
            [_radioOne setSelected:NO];
            [_radioTwo setSelected:YES];
            [_radioThree setSelected:NO];
            [_radioFour setSelected:NO];
            [_radioFive setSelected:NO];
            break;
        case 3:
            [_radioOne setSelected:NO];
            [_radioTwo setSelected:NO];
            [_radioThree setSelected:YES];
            [_radioFour setSelected:NO];
            [_radioFive setSelected:NO];
            break;
        case 4:
            [_radioOne setSelected:NO];
            [_radioTwo setSelected:NO];
            [_radioThree setSelected:NO];
            [_radioFour setSelected:YES];
            [_radioFive setSelected:NO];
            break;
        case 5:
            [_radioOne setSelected:NO];
            [_radioTwo setSelected:NO];
            [_radioThree setSelected:NO];
            [_radioFour setSelected:NO];
            [_radioFive setSelected:YES];
            break;
        default:
            [_radioOne setSelected:YES];
            [_radioTwo setSelected:NO];
            [_radioThree setSelected:NO];
            [_radioFour setSelected:NO];
            [_radioFive setSelected:NO];
            nMaxGoals = 1;
            break;
    }
    
    NSMutableArray *pWeekdays = [Common getRemindWeekdays];
    if( pWeekdays )
    {
        for( int i = 0; i < [pWeekdays count]; i++ )
        {
            NSString *szWeekday = [pWeekdays objectAtIndex:i];
            if([szWeekday isEqualToString:@"Monday"])
            {
                [_chkMonday setSelected:YES];
            }
            else if([szWeekday isEqualToString:@"Tuesday"])
            {
                [_chkTuesday setSelected:YES];
            }
            else if([szWeekday isEqualToString:@"Wednesday"])
            {
                [_chkWednesday setSelected:YES];
            }
            else if([szWeekday isEqualToString:@"Thursday"])
            {
                [_chkThursday setSelected:YES];
            }
            else if([szWeekday isEqualToString:@"Friday"])
            {
                [_chkFriday setSelected:YES];
            }
            else if([szWeekday isEqualToString:@"Saturday"])
            {
                [_chkSaturday setSelected:YES];
            }
            else if([szWeekday isEqualToString:@"Sunday"])
            {
                [_chkSunday setSelected:YES];
            }
            
        }
    }
}

#pragma mark - Max Goal Number Settings

- (IBAction)onOneButton:(id)sender {
    [_radioOne setSelected:YES];
    [_radioTwo setSelected:NO];
    [_radioThree setSelected:NO];
    [_radioFour setSelected:NO];
    [_radioFive setSelected:NO];
    nMaxGoals = 1;
}

- (IBAction)onTwoButton:(id)sender {
    [_radioOne setSelected:NO];
    [_radioTwo setSelected:YES];
    [_radioThree setSelected:NO];
    [_radioFour setSelected:NO];
    [_radioFive setSelected:NO];
    nMaxGoals = 2;
}

- (IBAction)onThreeButton:(id)sender {
    [_radioOne setSelected:NO];
    [_radioTwo setSelected:NO];
    [_radioThree setSelected:YES];
    [_radioFour setSelected:NO];
    [_radioFive setSelected:NO];
    nMaxGoals = 3;
}

- (IBAction)onFourButton:(id)sender {
    [_radioOne setSelected:NO];
    [_radioTwo setSelected:NO];
    [_radioThree setSelected:NO];
    [_radioFour setSelected:YES];
    [_radioFive setSelected:NO];
    nMaxGoals = 4;
}

- (IBAction)onFiveButton:(id)sender {
    [_radioOne setSelected:NO];
    [_radioTwo setSelected:NO];
    [_radioThree setSelected:NO];
    [_radioFour setSelected:NO];
    [_radioFive setSelected:YES];
    nMaxGoals = 5;
}

#pragma mark - Day of Week settings

- (IBAction)onMondayButton:(id)sender {
    if( [_chkMonday isSelected] )
        [_chkMonday setSelected:NO];
    else
        [_chkMonday setSelected:YES];
}

- (IBAction)onTuesdayButton:(id)sender {
    if( [_chkTuesday isSelected] )
        [_chkTuesday setSelected:NO];
    else
        [_chkTuesday setSelected:YES];
}

- (IBAction)onWednesdayButton:(id)sender {
    if( [_chkWednesday isSelected] )
        [_chkWednesday setSelected:NO];
    else
        [_chkWednesday setSelected:YES];
}

- (IBAction)onThursdayButton:(id)sender {
    if( [_chkThursday isSelected] )
        [_chkThursday setSelected:NO];
    else
        [_chkThursday setSelected:YES];
}

- (IBAction)onFridayButton:(id)sender {
    if([_chkFriday isSelected] )
        [_chkFriday setSelected:NO];
    else
        [_chkFriday setSelected:YES];
}

- (IBAction)onSaturdayButton:(id)sender {
    if( [_chkSaturday isSelected] )
        [_chkSaturday setSelected:NO];
    else
        [_chkSaturday setSelected:YES];
}

- (IBAction)onSundayButton:(id)sender {
    if( [_chkSunday isSelected] )
        [_chkSunday setSelected:NO];
    else
        [_chkSunday setSelected:YES];
}

- (IBAction)onNextButton:(id)sender {
    [Common setMaxGoals:nMaxGoals];
    [Common clearRemindWeekdays];    
    if( [_chkMonday isSelected] )
        [Common addRemindWeekday:@"Monday"];
    if( [_chkTuesday isSelected] )
        [Common addRemindWeekday:@"Tuesday"];
    if( [_chkWednesday isSelected] )
        [Common addRemindWeekday:@"Wednesday"];
    if( [_chkThursday isSelected] )
        [Common addRemindWeekday:@"Thursday"];
    if( [_chkFriday isSelected] )
        [Common addRemindWeekday:@"Friday"];
    if( [_chkSaturday isSelected] )
        [Common addRemindWeekday:@"Saturday"];
    if( [_chkSunday isSelected] )
        [Common addRemindWeekday:@"Sunday"];
    
    if( [[Common getRemindWeekdays] count] != 0 )
    {
        [self performSegueWithIdentifier:@"segueFromStepOne2Two" sender:self];
    }
    else
    {
        showToast(@"You must select more than one day.");
    }
    
}

@end