//
//  Todo+Functions.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "Todo.h"

@interface Todo (Functions)

- (BOOL)isOnDate:(NSDate *)date;
- (BOOL)isExpired;
- (void)setTodoDate : (NSDate*)date;

@end
