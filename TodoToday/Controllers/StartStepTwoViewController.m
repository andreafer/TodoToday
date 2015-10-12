//
//  StartStepTwoViewController.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StartStepTwoViewController.h"
#import "Common.h"
#import "GlobalFunc.h"
#import "Macros.h"
#import "Toast+UIView.h"
#import "ConstString.h"

@implementation StartStepTwoViewController

int nTimeButtonIndex = -1;
NSDate *firstTime = nil;
NSDate *secondTime = nil;
NSDate *thirdTime = nil;

#pragma mark - Navigation Controller

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *timeArray = [Common getRemindDates];
    firstTime = nil;
    secondTime = nil;
    thirdTime = nil;
    for( int i = 0; i < [timeArray count]; i++ )
    {
        NSDate *date = [timeArray objectAtIndex:i];
        NSString *szTemp = [GlobalFunc convertDateToString:date fmt:@"hh:mm a"];
        NSString *szDate = [szTemp substringToIndex:([szTemp length] - 3)];
        NSString *szAmPm = [szTemp substringFromIndex:([szTemp length] - 2)];

        switch(i)
        {
            case 0:
                firstTime = date;
                if( [szAmPm isEqualToString:@"AM"] )
                {
                    [_radFirstTimeAM setSelected:YES];
                    [_radFirstTimePM setSelected:NO];
                }
                else if( [szAmPm isEqualToString:@"PM"] )
                {
                    [_radFirstTimeAM setSelected:NO];
                    [_radFirstTimePM setSelected:YES];
                }
                
                [_btnFirstTime setTitle:szDate forState:UIControlStateNormal];

                break;
            case 1:
                secondTime = date;
                if( [szAmPm isEqualToString:@"AM"] )
                {
                    [_radSecondTimeAM setSelected:YES];
                    [_radSecondTimePM setSelected:NO];
                }
                else if( [szAmPm isEqualToString:@"PM"] )
                {
                    [_radSecondTimeAM setSelected:NO];
                    [_radSecondTimePM setSelected:YES];
                }
                
                [_btnSecondTime setTitle:szDate forState:UIControlStateNormal];
                break;
            case 2:
                thirdTime = date;
                if( [szAmPm isEqualToString:@"AM"] )
                {
                    [_radThirdTimeAM setSelected:YES];
                    [_radThirdTimePM setSelected:NO];
                }
                else if( [szAmPm isEqualToString:@"PM"] )
                {
                    [_radThirdTimeAM setSelected:NO];
                    [_radThirdTimePM setSelected:YES];
                }
                
                [_btnThirdTime setTitle:szDate forState:UIControlStateNormal];
                break;
        }
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if( [identifier isEqualToString:@"segueFromStepTwo2Three"] )
    {
        if( firstTime == nil && secondTime == nil && thirdTime == nil )
        {
            showToast(@"Please select the time you want to be notified.");
            return NO;
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"segueFromStepTwo2Three"] )
    {
        [Common clearRemindDates];
        if( firstTime != nil )
        {
            firstTime = [self getDateFromAmPm:firstTime timeindex:0];
            [Common addRemindDate:firstTime];
        }
        if( secondTime != nil )
        {
            secondTime = [self getDateFromAmPm:secondTime timeindex:1];
            [Common addRemindDate:secondTime];
        }
        if( thirdTime != nil )
        {
            thirdTime = [self getDateFromAmPm:thirdTime timeindex:2];
            [Common addRemindDate:thirdTime];
        }
    }
    
}

#pragma mark -
- (IBAction)onFirstTimeAM:(id)sender {
    if( firstTime == nil )
        return;
    [_radFirstTimeAM setSelected:YES];
    [_radFirstTimePM setSelected:NO];
}

- (IBAction)onFirstTimePM:(id)sender {
    if( firstTime == nil )
        return;
    [_radFirstTimeAM setSelected:NO];
    [_radFirstTimePM setSelected:YES];
}

- (IBAction)onSecondTimeAM:(id)sender {
    if( secondTime == nil )
        return;
    [_radSecondTimeAM setSelected:YES];
    [_radSecondTimePM setSelected:NO];

}

- (IBAction)onSecondTimePM:(id)sender {
    if( secondTime == nil )
        return;
    [_radSecondTimeAM setSelected:NO];
    [_radSecondTimePM setSelected:YES];

}

- (IBAction)onThirdTimeAM:(id)sender {
    if( thirdTime == nil )
        return;
    [_radThirdTimeAM setSelected:YES];
    [_radThirdTimePM setSelected:NO];
}

- (IBAction)onThirdTimePM:(id)sender {
    if( thirdTime == nil )
        return;
    [_radThirdTimeAM setSelected:NO];
    [_radThirdTimePM setSelected:YES];

}

- (IBAction)onNextButton:(id)sender {
    [self performSegueWithIdentifier:@"segueFromStepTwo2Three" sender:self];
}

- (NSDate*) getDateFromAmPm : (NSDate*)date timeindex:(int)index
{
    NSDate *retDate = nil;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *datecomp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    if( datecomp.hour >= 12 )
        datecomp.hour -= 12;
    switch( index )
    {
        case 0:     //case FirstTIme
            if( _radFirstTimePM.isSelected)
            {
                datecomp.hour += 12;
            }
            break;
        case 1:     //case SecondTime
            if( _radSecondTimePM.isSelected )
            {
                datecomp.hour += 12;
            }
            break;
        case 2:     //case ThirdTime
            if( _radThirdTimePM.isSelected )
            {
                datecomp.hour += 12;
            }
            break;
    }
    
    retDate = [calendar dateFromComponents:datecomp];
    
    return retDate;
}

#pragma mark - time picker

- (void)changeDate:(UIDatePicker *)sender {
    NSDate *date = sender.date;
    NSString *szTemp = [GlobalFunc convertDateToString:date fmt:@"hh:mm a"];
    NSString *szDate = [szTemp substringToIndex:([szTemp length] - 3)];
    NSString *szAmPm = [szTemp substringFromIndex:([szTemp length] - 2)];
    if( nTimeButtonIndex == 0 )
    {
        firstTime = date;
        if( [szAmPm isEqualToString:@"AM"] )
        {
            [_radFirstTimeAM setSelected:YES];
            [_radFirstTimePM setSelected:NO];
        }
        else if( [szAmPm isEqualToString:@"PM"] )
        {
            [_radFirstTimeAM setSelected:NO];
            [_radFirstTimePM setSelected:YES];
        }
        
        [_btnFirstTime setTitle:szDate forState:UIControlStateNormal];
        
    }
    else if( nTimeButtonIndex == 1 )
    {
        secondTime = date;
        if( [szAmPm isEqualToString:@"AM"] )
        {
            [_radSecondTimeAM setSelected:YES];
            [_radSecondTimePM setSelected:NO];
        }
        else if( [szAmPm isEqualToString:@"PM"] )
        {
            [_radSecondTimeAM setSelected:NO];
            [_radSecondTimePM setSelected:YES];
        }
        
        [_btnSecondTime setTitle:szDate forState:UIControlStateNormal];
    }
    else if( nTimeButtonIndex == 2 )
    {
        thirdTime = date;
        if( [szAmPm isEqualToString:@"AM"] )
        {
            [_radThirdTimeAM setSelected:YES];
            [_radThirdTimePM setSelected:NO];
        }
        else if( [szAmPm isEqualToString:@"PM"] )
        {
            [_radThirdTimeAM setSelected:NO];
            [_radThirdTimePM setSelected:YES];
        }
        
        [_btnThirdTime setTitle:szDate forState:UIControlStateNormal];
    }
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    [Common clearRemindDates];
    if( firstTime != nil )
    {
        firstTime = [self getDateFromAmPm:firstTime timeindex:0];
        [Common addRemindDate:firstTime];
    }
    if( secondTime != nil )
    {
        secondTime = [self getDateFromAmPm:secondTime timeindex:1];
        [Common addRemindDate:secondTime];
    }
    if( thirdTime != nil )
    {
        thirdTime = [self getDateFromAmPm:thirdTime timeindex:2];
        [Common addRemindDate:thirdTime];
    }
    
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

- (IBAction)onTimeButton:(id)sender {
    if( sender == _btnFirstTime )
    {
        nTimeButtonIndex = 0;
    }
    else if( sender == _btnSecondTime )
    {
        nTimeButtonIndex = 1;
    }
    else if( sender == _btnThirdTime )
    {
        nTimeButtonIndex = 2;
    }
    
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake((self.view.bounds.size.width - 320) / 2, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake((self.view.bounds.size.width - 320) / 2, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 1;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    datePicker.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1];
    datePicker.datePickerMode = UIDatePickerModeTime;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    [self changeDate:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}


- (IBAction)OnFirstTimeOffButton:(id)sender {
    [_radFirstTimeAM setSelected:NO];
    [_radFirstTimePM setSelected:NO];
    firstTime=nil;
}

- (IBAction)OnSecondButtonTimeOffButton:(id)sender {
    [_radSecondTimeAM setSelected:NO];
    [_radSecondTimePM setSelected:NO];
    secondTime=nil;
    
}

- (IBAction)OnThirdTimeOffButton:(id)sender {
    [_radThirdTimeAM setSelected:NO];
    [_radThirdTimePM setSelected:NO];
    thirdTime=nil;

}
@end