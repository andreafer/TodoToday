//
//  SuperViewController.m
//  BJPinChe
//
//  Created by Kimoc on 14-8-22.
//  Copyright (c) 2014年 KimOC. All rights reserved.
//

#import "SuperViewController.h"
//#import "Config.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * Initilaize all input controls 
 */
- (void) initInputControls
{
    // make tap recognizer to hide keyboard
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBackGround:)];
    
    [self.view addGestureRecognizer:tapRecognizer];
}

/**
 * Hide keyboard when tapped background
 */
- (void) handleTapBackGround:(id)sender
{
    [self.view endEditing:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // find next responder
    UIResponder * nextResp = [self.view viewWithTag:nextTag];
    if (nextResp) {
        // set it
        [nextResp becomeFirstResponder];
    } else {
        // hide keyboard
        [textField resignFirstResponder];
    }
    
    return NO;
}

/**
 * detect duplicate user
 * @param : result [in], error state message
 */
- (void) duplicateUser:(NSString *)result
{
    NSLog(@"Detect duplicate user");
    
//    [SVProgressHUD dismissWithError:result afterDelay:DEF_DELAY];
//    [self performSelector:@selector(duplicateLogout) withObject:nil afterDelay:DEF_DELAY];
}

- (void) duplicateLogout
{
//    // remove account data
//    [Common setUserInfo:nil];
//    
//    // go to main view controller
//    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"maintab"];
//    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)onTapBack:(id)sender {
    
    if (self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


@end
