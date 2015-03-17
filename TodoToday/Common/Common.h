//
//  Common.h
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Common : NSObject {
}

+ (void) setMaxGoals : (NSInteger)maxGoals;
+ (NSInteger) getMaxGoals;

+ (void) setAlarmSound : (NSString*)szAlarmSound;
+ (NSString*) getAlarmSound;

+ (void) addRemindWeekday : (NSString *)szWeekday;
+ (void) clearRemindWeekdays;
+ (NSMutableArray*) getRemindWeekdays;

+ (void) addRemindDate : (NSDate*)date;
+ (void) clearRemindDates;
+ (NSMutableArray*) getRemindDates;

+ (NSInteger) MAXLENGTH;

+ (void) checkForYesterdayTodoAndAdd;

+ (NSDate*) getYesterdayDate;

@end
