//
//  Reminder.h
//  TodoToday
//
//  Created by HongYun on 3/8/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RemindTime;

@interface Reminder : NSManagedObject

@property (nonatomic, retain) NSString * alarm_sound;
@property (nonatomic, retain) NSString * remind_weekday;
@property (nonatomic, retain) NSNumber * todo_completed;
@property (nonatomic, retain) NSNumber * todo_total;
@property (nonatomic, retain) RemindTime *time;

@end
