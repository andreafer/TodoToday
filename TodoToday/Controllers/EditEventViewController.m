//
//  EditEventViewController.m
//  TodoToday
//
//  Created by HongYun on 3/10/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "EditEventViewController.h"
#import "TodoDate.h"
#import "Todo+Functions.h"
#import "Toast+UIView.h"
#import "Macros.h"
#import "ConstString.h"
#import "TodoDateReminder.h"
#import "Common.h"

@implementation EditEventViewController

NSDate *todo_Date = nil;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)viewDidLoad
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.year = [_todo.date.year integerValue];
    comp.month = [_todo.date.month integerValue];
    comp.day = [_todo.date.day integerValue];
    todo_Date = [cal dateFromComponents:comp];
    TodoDate *date = _todo.date;
    NSString *szDate = [[NSString alloc] initWithFormat:@"%02ld/%02ld/%ld", (long)[date.month integerValue], (long)[date.day integerValue], (long)[date.year integerValue]];
    [_txtDate setTitle:szDate forState:UIControlStateNormal];
    [_txtContent setText:_todo.title];
    
    [super viewDidLoad];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if( [identifier isEqualToString:@"segueUnwind"] )
    {
        if( [_txtContent.text isEqualToString:@""] )
        {
            showToast(@"Please input the ToDo title.");
            return NO;
        }
        
        int nNumberOfTodoOnDate = 0;
        
        for( Todo *todo in [Todo MR_findAll]) {
            if( [todo isOnDate:todo_Date] && [todo.isCompleted boolValue] == NO)
            {
                nNumberOfTodoOnDate++;
            }
        }
        
        if( nNumberOfTodoOnDate >= [Common getMaxGoals] )
        {
            showToast(@"You have already maximum number of ToDo items on your selected day. Please increase your Maximum in the setup.");
            return NO;
        }
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"segueUnwind"] )
    {
        NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
        Todo *todo = [Todo MR_findFirstByAttribute:@"title" withValue:_todo.title inContext:localContext];
        TodoDate *date = [TodoDate MR_createInContext:localContext];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *comp = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:todo_Date];
        date.year = [[NSNumber alloc] initWithInteger:comp.year];
        date.month = [[NSNumber alloc] initWithInteger:comp.month];
        date.day = [[NSNumber alloc] initWithInteger:comp.day];
        todo.date = date;
        todo.title = _txtContent.text;
        
        [localContext MR_saveToPersistentStoreAndWait];
        [[[TodoDateReminder alloc] init] updateReminders];
    }
}

#pragma mark Date Picker Delegate

- (void)changeDate:(UIDatePicker *)sender {
    todo_Date = sender.date;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    _txtDate.titleLabel.text = [format stringFromDate:todo_Date];
    [_txtDate setTitle:[format stringFromDate:todo_Date] forState:UIControlStateNormal];
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

- (IBAction)onDateButton:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake((self.view.bounds.size.width - 320) / 2, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake((self.view.bounds.size.width - 320) / 2, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 1;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    datePicker.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self changeDate:datePicker];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}

#pragma mark - screen auto-scrolling when keyboard is show up

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_txtContent])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_txtContent])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}
@end
