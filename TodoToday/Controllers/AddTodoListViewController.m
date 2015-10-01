//
//  AddTodoListViewController.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "Common.h"
#import "AddTodoListViewController.h"
#import "TodoTableViewCell.h"
#import "Todo.h"
#import "TodoDate.h"
#import "TodoDate+Functions.h"
#import "TodoDateReminder.h"
#import "Macros.h"
#import "Toast+UIView.h"
#import "ConstString.h"
#import "EditEventViewController.h"
#import "AddFutureEventViewController.h"

@implementation AddTodoListViewController
{
    
}

NSMutableArray *todoArray = nil;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    todoArray = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( ![todo.date isExpired:[NSDate date]] )
            continue;
        if( [todo.isCompleted boolValue] == NO )
            [todoArray addObject:todo];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"segueToEditEvent"])
    {
        EditEventViewController *editController = [segue destinationViewController];
        editController.todo = [todoArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    if( [segue.identifier isEqualToString:@"segueToAddEvent"])
    {
        AddFutureEventViewController *addController = [segue destinationViewController];
//        addController.bIsFutureEvent = [NSNumber numberWithBool:YES];
    }
}

#pragma mark - Table View Data Source, Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [todoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.lblItemNumber setText:[NSString stringWithFormat:@"%d.", indexPath.row + 1]] ;
    Todo *todo = [todoArray objectAtIndex:indexPath.row];
    [cell.lblItemContent setText:todo.title];
    if( [todo.isCompleted boolValue] == NO )
        [cell.btnCheck setSelected:NO];
    if( [todo.isCompleted boolValue] == YES )
        [cell.btnCheck setSelected:YES];
    
    [cell setTag:indexPath.row];
    
    return cell;
}

- (IBAction)onDeleteButton:(id)sender {
    bool bAvailable = NO;
    for( int i = 0; i < [_tableView numberOfRowsInSection:0]; i++ )
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        TodoTableViewCell *cell = (TodoTableViewCell*)[_tableView cellForRowAtIndexPath:path];
        
        if( [cell.btnCheck isSelected] )
        {
            bAvailable = YES;
            break;
        }
    }
    
    if( !bAvailable )
    {
        showToast(@"You have not selected any item.");
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Todo Today" message:@"Did you completed all of the selected items?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert setTag:1];
    [alert show];
}

- (IBAction)onAddButton:(id)sender {
    bool bAvailable = NO;
    for( int i = 0; i < [_tableView numberOfRowsInSection:0]; i++ )
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        TodoTableViewCell *cell = (TodoTableViewCell*)[_tableView cellForRowAtIndexPath:path];
        
        if( [cell.btnCheck isSelected] )
        {
            bAvailable = YES;
            break;
        }
    }
    
    if( !bAvailable )
    {
        showToast(@"You have not selected any item.");
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Todo Today" message:@"Do you want add selected items to your ToDo list today?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert setTag:2];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // do something here...
    }
    if (buttonIndex == 1 && [alertView tag] == 1) {
        for( int i = 0; i < [_tableView numberOfRowsInSection:0]; i++ )
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            TodoTableViewCell *cell = (TodoTableViewCell*)[_tableView cellForRowAtIndexPath:path];
            
            if( [cell.btnCheck isSelected] )
            {
                [cell.btnCheck setSelected:NO];
                Todo *item = [todoArray objectAtIndex:i];
                item.isCompleted = [[NSNumber alloc] initWithBool:YES];
            }
        }
        
        NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
        [localContext MR_saveToPersistentStoreAndWait];
        
        todoArray = [[NSMutableArray alloc] init];
        for( Todo *todo in [Todo MR_findAll] )
        {
            if( ![todo.date isExpired:[NSDate date]] )
                continue;
            if( [todo.isCompleted boolValue] == NO )
                [todoArray addObject:todo];
        }
        [self.tableView reloadData];
    }
    else if(buttonIndex == 1 && [alertView tag] == 2)
    {
        NSInteger nTodayIncompletedItems = 0, nYesterdayIncompletedItems = 0;
        
        nTodayIncompletedItems = [[[TodoDateReminder alloc] init] getIncompletedTodoNumberOnDate:[NSDate date]];
        nYesterdayIncompletedItems = [[[TodoDateReminder alloc] init] getIncompletedTodoNumberOnDate:[Common getYesterdayDate]];
        
//        if( nTodayIncompletedItems + nYesterdayIncompletedItems > [Common getMaxGoals])
//        {
//            showToast(@"Please delete one of your items or increase your Maximum in the setup.");
//            return;
//        }
        
        [Common checkForYesterdayTodoAndAdd];
        showToast(@"Your items have been added to the today's ToDo list successfully!");
        todoArray = [[NSMutableArray alloc] init];
        for( Todo *todo in [Todo MR_findAll] )
        {
            if( ![todo.date isExpired:[NSDate date]] )
                continue;
            if( [todo.isCompleted boolValue] == NO )
                [todoArray addObject:todo];
        }
        [self.tableView reloadData];
    }
}

- (IBAction)onTodoItemAdded:(UIStoryboardSegue *)segue
{
    showToast(@"Your ToDo item has been successfully added!");
    todoArray = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( ![todo.date isExpired:[NSDate date]] )
            continue;
        if( [todo.isCompleted boolValue] == NO )
            [todoArray addObject:todo];
    }
    [self.tableView reloadData];
}

- (IBAction)onTodoItemModified:(UIStoryboardSegue *)segue
{
    showToast(@"Your ToDo item has been successfully modified!");
    todoArray = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( ![todo.date isExpired:[NSDate date]] )
            continue;
        if( [todo.isCompleted boolValue] == NO )
            [todoArray addObject:todo];
    }
    [self.tableView reloadData];
}

@end