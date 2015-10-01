//
//  StartStepCompleteViewController.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface StartStepCompleteViewController : SuperViewController <UITableViewDelegate, UITableViewDataSource>
{
    
}

//Methods
- (void)processIfTableIsEmpty;

//UI Properties
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblNoItem;

//Todo Item Add/Remove Delegates
- (IBAction)onTodoItemAdded:(UIStoryboardSegue *)segue;
- (IBAction)onTodoItemModified:(UIStoryboardSegue *)segue;

@end
