//
//  StartStepCompleteViewController.m
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StartStepCompleteViewController.h"
#import "TodoTableViewCell.h"
#import "Macros.h"
#import "ConstString.h"
#import "Toast+UIView.h"
#import "Todo.h"
#import "Todo+Functions.h"
#import "Common.h"
#import "EditEventViewController.h"
#import "AddFutureEventViewController.h"

@implementation StartStepCompleteViewController

NSMutableArray *todosOnDate = nil;

-(void)viewDidLoad
{
    todosOnDate = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( /*[todo isOnDate:[NSDate date]] && */[todo.isCompleted boolValue] == NO )
        {
            [todosOnDate addObject:todo];
        }
    }
    [self.tableView reloadData];
    [self processIfTableIsEmpty];
    
    [super viewDidLoad];
}

#pragma mark - Methods

- (void) processIfTableIsEmpty {
    if( [todosOnDate count] == 0 )
        [_lblNoItem setAlpha:1.0];
    else
        [_lblNoItem setAlpha:0];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"segueToEditEvent"])
    {
        EditEventViewController *editController = [segue destinationViewController];
        editController.todo = [todosOnDate objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    if( [segue.identifier isEqualToString:@"segueToAddEvent"])
    {
//        AddFutureEventViewController *addController = [segue destinationViewController];
//        addController.bIsFutureEvent = [NSNumber numberWithBool:NO];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger todoNumber = [todosOnDate count];
    
    if( todoNumber > [Common getMaxGoals] )
        todoNumber = [Common getMaxGoals];
    
    return todoNumber;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Todo *todo =[todosOnDate objectAtIndex:indexPath.row];
    cell.lblItemNumber.text = [[NSString alloc] initWithFormat:@"%ld.", (long)indexPath.row + 1];
    cell.lblItemContent.text = [todo title];
    
    return cell;
}

- (IBAction)onTodoItemAdded:(UIStoryboardSegue *)segue
{
    showToast(@"Your ToDo item has been successfully added!");
    todosOnDate = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( /*[todo isOnDate:[NSDate date]] && */[todo.isCompleted boolValue] == NO )
        {
            [todosOnDate addObject:todo];
        }
    }
    [self.tableView reloadData];
    [self processIfTableIsEmpty];
}

- (IBAction)onTodoItemModified:(UIStoryboardSegue *)segue
{
    showToast(@"Your ToDo item has been successfully modified.");
    todosOnDate = [[NSMutableArray alloc] init];
    for( Todo *todo in [Todo MR_findAll] )
    {
        if( /*[todo isOnDate:[NSDate date]] && */[todo.isCompleted boolValue] == NO )
        {
            [todosOnDate addObject:todo];
        }
    }
    [self.tableView reloadData];
    [self processIfTableIsEmpty];
}

@end