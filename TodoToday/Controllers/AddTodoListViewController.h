//
//  AddTodoListViewController.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface AddTodoListViewController : SuperViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onDeleteButton:(id)sender;
- (IBAction)onAddButton:(id)sender;
- (IBAction)onTodoItemAdded:(UIStoryboardSegue *)segue;
- (IBAction)onTodoItemModified:(UIStoryboardSegue *)segue;

@end
