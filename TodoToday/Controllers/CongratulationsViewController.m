//
//  CongratulationsViewController.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CongratulationsViewController.h"
#import "TodoDateReminder.h"

@implementation CongratulationsViewController
{
    
}

-(void)viewDidLoad
{
    NSInteger nTotal = [[[TodoDateReminder alloc] init] getTotalDaysByDate:[NSDate date]];
    NSInteger nComplete = [[[TodoDateReminder alloc] init] getCompletedDaysByDate:[NSDate date]];

    NSString *text = [_txtSuccessedItems text];
    text = [text stringByReplacingOccurrencesOfString:@"XX" withString:[NSString stringWithFormat:@"%ld", (long)nComplete]];
    text = [text stringByReplacingOccurrencesOfString:@"ZZ" withString:[NSString stringWithFormat:@"%ld", (long)nTotal]];
    [_txtSuccessedItems setText:text];
    [super viewDidLoad];
}

@end