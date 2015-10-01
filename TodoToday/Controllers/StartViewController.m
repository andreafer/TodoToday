//
//  StartViewController.m
//  TodoToday
//
//  Created by HongYun on 3/4/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import "StartViewController.h"
#import "AddTodoListViewController.h"
#import "Config.h"

@interface StartViewController ()

@end

@implementation StartViewController

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onStartButton:(id)sender {
    [self performSegueWithIdentifier:@"segueToSettings" sender:self];
}
@end
