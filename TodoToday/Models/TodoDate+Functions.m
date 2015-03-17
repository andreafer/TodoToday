//
//  TodoDate+Functions.m
//  TodoToday
//
//  Created by HongYun on 3/8/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "TodoDate+Functions.h"

@implementation TodoDate (Functions)

- (BOOL)isExpired : (NSDate*) date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:units fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    if( [self.year integerValue] > year )
        return NO;
    if( [self.year integerValue] == year && [self.month integerValue] > month )
        return NO;
    if( [self.year integerValue] == year && [self.month integerValue] == month && [self.day integerValue] >= day )
        return NO;
    return YES;
}


@end