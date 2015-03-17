//
//  EditEventViewController.h
//  TodoToday
//
//  Created by HongYun on 3/10/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//
#import "Todo.h"
#import "SuperViewController.h"

@interface EditEventViewController : SuperViewController <UITextFieldDelegate>
{
}

@property (nonatomic) Todo *todo;
@property (weak, nonatomic) IBOutlet UIButton *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtContent;
- (IBAction)onDateButton:(id)sender;
@end