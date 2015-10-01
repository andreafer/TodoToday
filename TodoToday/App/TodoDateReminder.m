//
//  TodoDateReminder.m
//  TodoToday
//
//  Created by HongYun on 3/8/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "TodoDateReminder.h"
#import <UIKit/UILocalNotification.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIUserNotificationSettings.h>
#import "Todo.h"
#import "Todo+Functions.h"
#import "TodoDate.h"
#import "TodoDate+Functions.h"
#import "AppDelegate.h"
#import "Common.h"

@implementation TodoDateReminder

- (void) addReminder:(id)reminder
{
    [self scheduleLocalNotificationForEvent:reminder];
}

static NSString *LOCAL_NOTIFICATION_KEY = @"reminder_id";

-(void) scheduleLocalNotificationForEvent:(Reminder *)reminder
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
  
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *fireDate = [self getDateFromWeekday:reminder.remind_weekday];
    
    NSDateComponents *components = [calendar components: NSCalendarUnitYear|
                                                         NSCalendarUnitMonth|
                                                         NSCalendarUnitDay|
                                                         NSCalendarUnitHour|
                                                         NSCalendarUnitMinute
                                                         fromDate:fireDate];
    [components setHour:[reminder.time.hour intValue]];
    [components setMinute:[reminder.time.minute intValue]];
    [components setSecond:0];
    fireDate = [calendar dateFromComponents:components];
    
    NSString *szRemindContent = [[NSString alloc] initWithFormat:@"Completion of %d out of %d goals today\nClick to access goals", [[reminder todo_completed] intValue], [[reminder todo_total] intValue]];
    
    localNotif.fireDate = fireDate;
    localNotif.repeatInterval = NSCalendarUnitWeekday;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = szRemindContent;
    localNotif.soundName = reminder.alarm_sound;
    localNotif.applicationIconBadgeNumber = [[reminder todo_total] intValue] - [[reminder todo_completed] intValue];

    NSString *eid = [[[reminder objectID] URIRepresentation] absoluteString];
    NSLog(@"scheduleLocalNotificationForEvent: %@", eid);
    NSDictionary *info = [NSDictionary dictionaryWithObject:eid forKey:LOCAL_NOTIFICATION_KEY];
    localNotif.userInfo = info;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
}

- (void) updateReminders
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    for( NSDate *date in [Common getRemindDates] )
    {
        for( NSString *weekday in [Common getRemindWeekdays] )
        {
            NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
            Reminder *reminder = [Reminder MR_createInContext:localContext];
            RemindTime *remindtime = [RemindTime MR_createInContext:localContext];
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            [calendar setLocale:[NSLocale currentLocale]];
            NSDateComponents *datecomp = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
            remindtime.hour = [NSNumber numberWithInteger:datecomp.hour];
            remindtime.minute = [NSNumber numberWithInteger:datecomp.minute];
            reminder.remind_weekday = weekday;
            reminder.time = remindtime;
            if( [[Common getAlarmSound] isEqualToString:@""] )
            {
                reminder.alarm_sound = UILocalNotificationDefaultSoundName;
            }
            else
            {
                reminder.alarm_sound = [Common getAlarmSound];
            }
            
            reminder.todo_completed = [[NSNumber alloc] initWithInteger:[[[TodoDateReminder alloc] init] getCompletedTodoNumberOnDate:[self getDateFromWeekday:reminder.remind_weekday]]];
            reminder.todo_total = [[NSNumber alloc] initWithInteger:[[[TodoDateReminder alloc] init] getTotalTodoNumberOnDate:[self getDateFromWeekday:reminder.remind_weekday]]];
            [localContext MR_saveToPersistentStoreAndWait];
            [[[TodoDateReminder alloc] init] addReminder:reminder];
        }
    }
}

- (NSInteger) getWeekdayIndexFromString:(NSString *)szWeekday
{
    if( [szWeekday isEqualToString:@"Monday"] )
    {
        return 1;
    }
    else if( [szWeekday isEqualToString:@"Tuesday"] )
    {
        return 2;
    }
    else if( [szWeekday isEqualToString:@"Wednesday"] )
    {
        return 3;
    }
    else if( [szWeekday isEqualToString:@"Thursday"] )
    {
        return 4;
    }
    else if( [szWeekday isEqualToString:@"Friday"] )
    {
        return 5;
    }
    else if( [szWeekday isEqualToString:@"Saturday"] )
    {
        return 6;
    }
    else if( [szWeekday isEqualToString:@"Sunday"] )
    {
        return 7;
    }
    
    return 0;
}

- (NSDate *)getDateFromWeekday:(NSString *)szWeekday
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateformat setDateFormat:@"EEEE"];
    NSString *szTodayWeekday = [dateformat stringFromDate:today];
    NSDateComponents *comps = [NSDateComponents new];

    
    if( [self getWeekdayIndexFromString:szWeekday] >= [self getWeekdayIndexFromString:szTodayWeekday] )
        comps.day = [self getWeekdayIndexFromString:szWeekday] - [self getWeekdayIndexFromString:szTodayWeekday];
    else
        comps.day = 7 - ([self getWeekdayIndexFromString:szTodayWeekday] - [self getWeekdayIndexFromString:szWeekday]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
}

- (NSMutableArray*) getTodoItemsForDate : (NSDate*)date
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    for( Todo *todo in [Todo MR_findAll])
    {
        if( [todo.date.year intValue] == comp.year && [todo.date.month intValue] == comp.month && [todo.date.day intValue] == comp.day )
        {
            [retArray addObject:todo];
        }
    }

    return retArray;
}

- (NSInteger) getIncompletedTodoNumberOnDate : (NSDate*)date
{
    int nRetValue = 0;
    
    for( Todo *todo in [Todo MR_findAll])
    {
        if( [todo isOnDate:date] && [todo.isCompleted boolValue] == NO )
        {
            nRetValue++;
        }
    }
    
    return nRetValue;
}

- (NSInteger) getCompletedTodoNumberOnDate : (NSDate*)date
{
    int nRetValue = 0;
    
    for( Todo *todo in [Todo MR_findAll])
    {
        if( [todo isOnDate:date] && [todo.isCompleted boolValue] == YES )
        {
            nRetValue++;
        }
    }
    
    return nRetValue;
}

- (NSInteger) getTotalTodoNumberOnDate : (NSDate*)date
{
    int nRetValue = 0;
    
    for( Todo *todo in [Todo MR_findAll])
    {
        if( [todo isOnDate:date] )
        {
            nRetValue++;
        }
    }
    
    return nRetValue;
}

- (NSInteger) getTotalDaysByDate : (NSDate*)date
{
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    for( TodoDate *tododate in [TodoDate MR_findAll])
    {
        bool bIsExist = NO;
        for( int i = 0; i < [dateArray count]; i++)
        {
            if( tododate.year == ((TodoDate *)[dateArray objectAtIndex:i]).year &&
                tododate.month== ((TodoDate *)[dateArray objectAtIndex:i]).month&&
                tododate.day  == ((TodoDate *)[dateArray objectAtIndex:i]).day)
            {
                bIsExist = YES;
                break;
            }
        }
        
        if( !bIsExist )
        {
            if( [tododate isExpired:[NSDate date]] )
                [dateArray addObject:tododate];
        }
    }
    
    return [dateArray count] + 1;
}

- (NSInteger) getCompletedDaysByDate : (NSDate*)date
{
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll])
    {
        bool bIsExist = NO;
        if( [todo.isCompleted boolValue] == YES )
        {
            for( int i = 0; i < [dateArray count]; i++)
            {
                if( todo.date.year == ((TodoDate *)[dateArray objectAtIndex:i]).year &&
                   todo.date.month== ((TodoDate *)[dateArray objectAtIndex:i]).month&&
                   todo.date.day  == ((TodoDate *)[dateArray objectAtIndex:i]).day)
                {
                    bIsExist = YES;
                    break;
                }
            }
            
            if( !bIsExist )
            {
                if( [todo.date isExpired:[NSDate date]] )
                    [dateArray addObject:todo.date];
            }
        }
    }
    
    return [dateArray count] + 1;
}

@end
