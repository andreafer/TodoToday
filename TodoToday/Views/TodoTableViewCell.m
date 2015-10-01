//
//  TodoTableViewCell.m
//  TodoToday
//
//  Created by HongYun on 3/7/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodoTableViewCell.h"

@implementation TodoTableViewCell

- (IBAction)onCheckButton:(id)sender {
    
    if( [_btnCheck isSelected] )
        [_btnCheck setSelected:NO];
    else
        [_btnCheck setSelected:YES];
}
@end
