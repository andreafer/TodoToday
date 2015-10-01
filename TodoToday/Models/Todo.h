//
//  Todo.h
//  TodoToday
//
//  Created by HongYun on 3/8/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TodoDate;

@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) TodoDate *date;

@end
