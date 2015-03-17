//
//  TodoTableViewCell.h
//  TodoToday
//
//  Created by HongYun on 3/7/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoTableViewCell : UITableViewCell
{}

@property (weak, nonatomic) IBOutlet UILabel *lblItemNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblItemContent;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;


- (IBAction)onCheckButton:(id)sender;

@end
