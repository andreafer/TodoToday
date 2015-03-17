//
//  TodayGoalsViewController.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface TodayGoalsViewController : SuperViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

//Methods
- (void)processIfTableIsEmpty;
- (BOOL)isAnyItemSelected;

//UIButton Actions
- (IBAction)onCompletedButtonClicked:(id)sender;
- (IBAction)onDeleteButtonClicked:(id)sender;

//Todo Item Add/Remove Delegates
- (IBAction)onTodoItemAdded:(UIStoryboardSegue*)segue;
- (IBAction)onTodoItemModified:(UIStoryboardSegue*)segue;

//UI Properties
@property (weak, nonatomic) IBOutlet UILabel *txtTodayDate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblNoItems;

@end