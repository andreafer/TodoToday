//
//  TodoDateReminder.h
//  TodoToday
//
//  Created by HongYun on 3/8/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "Reminder.h"
#import "RemindTime.h"

@interface TodoDateReminder : NSObject

- (void) addReminder : (Reminder *)reminder;
- (void) scheduleLocalNotificationForEvent : (Reminder *)reminder;
- (NSMutableArray*) getTodoItemsForDate : (NSDate*)date;
- (NSInteger) getWeekdayIndexFromString : (NSString *)szWeekday;
- (NSInteger) getIncompletedTodoNumberOnDate : (NSDate*)date;
- (NSInteger) getCompletedTodoNumberOnDate : (NSDate*)date;
- (NSInteger) getTotalTodoNumberOnDate : (NSDate*)date;
- (NSInteger) getTotalDaysByDate : (NSDate*)date;
- (NSInteger) getCompletedDaysByDate : (NSDate*)date;
- (void) updateReminders;
- (NSDate*) getDateFromWeekday : (NSString *)szWeekday;

@end