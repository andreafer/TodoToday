//
//  SuperViewController.h
//  BJPinChe
//
//  Created by Kimoc on 14-8-22.
//  Copyright (c) 2014年 KimOC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

- (void) initInputControls;
- (void) duplicateUser:(NSString *)result;
- (void) duplicateLogout;

- (IBAction)onTapBack:(id)sender;

@end
