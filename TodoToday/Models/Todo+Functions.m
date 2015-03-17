//
//  Todo+Functions.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "Todo+Functions.h"
#import "TodoDate.h"

@implementation Todo (Functions)

- (BOOL)isOnDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:units fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    if( [self.date.year integerValue] == year && [self.date.month integerValue] == month && [self.date.day integerValue] == day )
    {
        return YES;
    }

    return NO;
}

- (BOOL)isExpired
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:units fromDate:now];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    if( [self.date.year integerValue] > year )
        return NO;
    if( [self.date.year integerValue] == year && [self.date.month integerValue] > month )
        return NO;
    if( [self.date.year integerValue] == year && [self.date.month integerValue] == month && [self.date.day integerValue] >= day )
        return NO;
    return YES;
}

- (void)setTodoDate : (NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:units fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    [self.date setYear:[NSNumber numberWithInteger:year]];
    [self.date setMonth:[NSNumber numberWithInteger:month]];
    [self.date setDay:[NSNumber numberWithInteger:day]];
    

}

@end
