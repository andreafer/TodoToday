//
//  Common.m
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import "Common.h"
#import "Todo.h"
#import "Todo+Functions.h"
#import "TodoDate.h"
#import "TodoDate+Functions.h"

// Common variables

NSMutableArray  *_pRemindWeekdays = nil;
NSMutableArray  *_pRemindDates = nil;

double          _curPosLat = 0;
double          _curPosLng = 0;

#define _MAXLENGTH       50


@implementation Common

+ (void) setMaxGoals : (NSInteger)maxGoals
{
    if( maxGoals >= 1 && maxGoals <= 5)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *szMaxGoals = [NSString stringWithFormat:@"%ld", (long)maxGoals];
        [defaults setValue:szMaxGoals forKey:@"maxgoals"];
    }
}

+ (NSInteger) getMaxGoals
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *szMaxGoals = [defaults stringForKey:@"maxgoals"];
    NSInteger nMaxGoals = [szMaxGoals integerValue];
    return nMaxGoals;
}

+ (void) setAlarmSound : (NSString*)szAlarmSound
{
    if (szAlarmSound != nil)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:szAlarmSound forKey:@"alarmsound"];
    }
}

+ (NSString*) getAlarmSound
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if( [defaults stringForKey:@"alarmsound"] )
        return [defaults stringForKey:@"alarmsound"];
    else
        return @"";
}


+ (void)addRemindWeekday:(NSString *)szWeekday
{
    if (_pRemindWeekdays == nil )
        _pRemindWeekdays = [[NSMutableArray alloc] init];
    
    [_pRemindWeekdays addObject:szWeekday];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_pRemindWeekdays forKey:@"remindweekdays"];
}

+ (NSMutableArray *)getRemindWeekdays
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"remindweekdays"];
}

+ (void)clearRemindWeekdays
{
    [_pRemindWeekdays removeAllObjects];
}

+ (void) removeRemindDate:(NSUInteger)intDate{
    //( if ([_pRemindDates.c
    [_pRemindDates removeObjectAtIndex:(intDate)];
    
}

+ (void) addRemindDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSLog(@"%@", [formatter stringFromDate:date]);
    
    
    if( _pRemindDates == nil )
    {
        _pRemindDates = [[NSMutableArray alloc] init];
    }
    
    [_pRemindDates addObject:date];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_pRemindDates forKey:@"reminddates"];
}

+ (void) clearRemindDates
{
    [_pRemindDates removeAllObjects];
}

+(NSMutableArray*) getRemindDates
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"reminddates"];
}

+ (NSInteger ) MAXLENGTH
{
    return _MAXLENGTH;
}

+ (void)checkForYesterdayTodoAndAdd
{
    NSDate *today = [NSDate date];
    NSDate *yesterday = [self getYesterdayDate];
    NSMutableArray *yesterdayTodos = [[NSMutableArray alloc] init];
    NSInteger nNumOfTodoToday = 0/*, nAvailable = 0*/;
    
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( [todo isOnDate:today] && [todo.isCompleted boolValue] == NO)
        {
            nNumOfTodoToday++;
        }
        else if( [todo isOnDate:yesterday] && [todo.isCompleted boolValue] == NO)
        {
            [yesterdayTodos addObject:todo];
        }
    }
/*
    nAvailable = [self getMaxGoals] - nNumOfTodoToday;
    
    if( nAvailable > 0 )
    {
        nAvailable = nAvailable > [yesterdayTodos count] ? [yesterdayTodos count] : nAvailable;
        for( int i = 0; i < nAvailable; i++ )
        {
            Todo *item = [yesterdayTodos objectAtIndex:i];
            [item setTodoDate:today];
        }
        NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
        [localContext MR_saveToPersistentStoreAndWait];
    }
*/
    for( int i = 0; i < [yesterdayTodos count]; i++ )
    {
        Todo *item = [yesterdayTodos objectAtIndex:i];
        [item setTodoDate:today];
    }
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
    [localContext MR_saveToPersistentStoreAndWait];
}

+ (NSDate*) getYesterdayDate
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:-1];
    
    return [gregorian dateByAddingComponents:comp toDate:today options:0];
}

@end
