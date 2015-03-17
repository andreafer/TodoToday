//
//  TodayGoalsViewController.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "TodayGoalsViewController.h"
#import "TodoTableViewCell.h"
#import "TodoDateReminder.h"
#import "Todo.h"
#import "Todo+Functions.h"
#import "Common.h"
#import "Macros.h"
#import "ConstString.h"
#import "Toast+UIView.h"
#import "EditEventViewController.h"
#import "AddFutureEventViewController.h"

@implementation TodayGoalsViewController

//Today's ToDos Array
NSMutableArray *todos = nil;

#pragma mark - UIViewController methods

-(void)viewDidLoad
{
    //Rolling over the ToDos of the day before.
    [Common checkForYesterdayTodoAndAdd];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormat setDateFormat:@"MMMM dd, yyyy"];
    [_txtTodayDate setText:[dateFormat stringFromDate:[NSDate date]]];

    //Fetches incompleted and on-date Todos from database.
    todos = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( [todo isOnDate:[NSDate date]] && [todo.isCompleted boolValue] == NO )
        {
            [todos addObject:todo];
        }
    }
    [self processIfTableIsEmpty];
    
    //Update all reminders because Total Todo Num and Completed Tood Num have to be updated for the next remind days.
    [[[TodoDateReminder alloc] init] updateReminders];
    
    [super viewDidLoad];
}

#pragma mark - Methods

- (void) processIfTableIsEmpty {
    if( [todos count] == 0 )
        [_lblNoItems setAlpha:1.0];
    else
        [_lblNoItems setAlpha:0];
}

- (BOOL) isAnyItemSelected {
    for( int i = 0; i < [_tableView numberOfRowsInSection:0]; i++ )
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        TodoTableViewCell *cell = (TodoTableViewCell*)[_tableView cellForRowAtIndexPath:path];
        
        if( [cell.btnCheck isSelected] )
        {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - UIButton Actions

- (IBAction)onCompletedButtonClicked:(id)sender {
    if( ![self isAnyItemSelected] )
    {
        showToast(NO_SELECTED_ITEM);
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:APP_TITLE message:QUESTION_COMPLETE_SELECTED delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView setTag:0];
    [alertView show];
}

- (IBAction)onDeleteButtonClicked:(id)sender {
    if( ![self isAnyItemSelected] )
    {
        showToast(NO_SELECTED_ITEM);
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:APP_TITLE message:QUESTION_DELETE_SELECTED delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView setTag:1];
    [alertView show];
}

#pragma mark - UINavigationController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"segueToEditEvent"])
    {
        EditEventViewController *editController = [segue destinationViewController];
        editController.todo = [todos objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    if( [segue.identifier isEqualToString:@"segueToAddEvent"])
    {
//        AddFutureEventViewController *addController = [segue destinationViewController];
//        addController.bIsFutureEvent = [NSNumber numberWithBool:YES];
    }
}

#pragma mark - UITableView DataSource, Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger todoNumber = [todos count];
    
    if( todoNumber > [Common getMaxGoals] )
        todoNumber = [Common getMaxGoals];
    
    return todoNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.lblItemNumber setText:[NSString stringWithFormat:@"%ld.", indexPath.row + 1]] ;
    Todo *todo = [todos objectAtIndex:indexPath.row];
    [cell.lblItemContent setText:todo.title];
    return cell;
}

#pragma mark - Todo Item Add/Remove Delegates

- (IBAction)onTodoItemAdded:(UIStoryboardSegue*)segue
{
    showToast(INFORMATION_TODO_ADD_SUCCESS);
    todos = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( [todo isOnDate:[NSDate date]] && [todo.isCompleted boolValue] == NO )
        {
            [todos addObject:todo];
        }
    }
    [_tableView reloadData];
    [self processIfTableIsEmpty];
}

- (IBAction)onTodoItemModified:(UIStoryboardSegue*)segue
{
    showToast(INFORMATION_TODO_MODIFY_SUCCESS);
    todos = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( [todo isOnDate:[NSDate date]] && [todo.isCompleted boolValue] == NO )
        {
            [todos addObject:todo];
        }
    }
    [_tableView reloadData];
    [self processIfTableIsEmpty];
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSInteger tag = [alertView tag];
    
    if( buttonIndex == 1 )
    {
        BOOL bMustUpdateRemind = NO;
        NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
        
        if( tag == 0 )
        {
            for( int i = 0; i < [_tableView numberOfRowsInSection:0]; i++ )
            {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                TodoTableViewCell *cell = (TodoTableViewCell*)[_tableView cellForRowAtIndexPath:path];
                
                if( [cell.btnCheck isSelected] )
                {
                    Todo *item = [todos objectAtIndex:i];
                    item.isCompleted = [[NSNumber alloc] initWithBool:YES];
                    [cell.btnCheck setSelected:NO];
                    bMustUpdateRemind = YES;
                }
            }

        }
        else if( tag == 1 )
        {
            for( int i = 0; i < [_tableView numberOfRowsInSection:0]; i++ )
            {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                TodoTableViewCell *cell = (TodoTableViewCell*)[_tableView cellForRowAtIndexPath:path];
                
                if( [cell.btnCheck isSelected] )
                {
                    Todo *item = [todos objectAtIndex:i];
                    [item MR_deleteEntity];
                    [cell.btnCheck setSelected:NO];
                    bMustUpdateRemind = YES;
                }
            }
        }
        [localContext MR_saveToPersistentStoreAndWait];
        if( bMustUpdateRemind )
            [[[TodoDateReminder alloc] init] updateReminders];
        
        todos = [[NSMutableArray alloc] init];
        for( Todo *todo in [Todo MR_findAll] )
        {
            if( [todo isOnDate:[NSDate date]] && [todo.isCompleted boolValue] == NO )
            {
                [todos addObject:todo];
            }
        }
        [_tableView reloadData];
        [self processIfTableIsEmpty];
        
        if( tag == 0 && [todos count] == 0 )
        {
            [self performSegueWithIdentifier:@"segueFromTodayGoals2Complete" sender:self];
        }
    }
}

@end