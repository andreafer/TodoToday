//
//  StartStepTwoViewController.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface StartStepTwoViewController : SuperViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *radFirstTimeAM;
@property (weak, nonatomic) IBOutlet UIButton *radFirstTimePM;
@property (weak, nonatomic) IBOutlet UIButton *radSecondTimeAM;
@property (weak, nonatomic) IBOutlet UIButton *radSecondTimePM;
@property (weak, nonatomic) IBOutlet UIButton *radThirdTimeAM;
@property (weak, nonatomic) IBOutlet UIButton *radThirdTimePM;
@property (weak, nonatomic) IBOutlet UIButton *btnFirstTime;
@property (weak, nonatomic) IBOutlet UIButton *btnSecondTime;
@property (weak, nonatomic) IBOutlet UIButton *btnThirdTime;

@property (weak, nonatomic) IBOutlet UIButton *btnFirstTimeOffButton;
@property (weak, nonatomic) IBOutlet UIButton *btnSecondTimeOffButton;
- (IBAction)OnFirstTimeOffButton:(id)sender;
- (IBAction)OnSecondButtonTimeOffButton:(id)sender;

- (IBAction)OnThirdTimeOffButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnThirdTimeOffButton;

- (IBAction)onFirstTimeAM:(id)sender;
- (IBAction)onFirstTimePM:(id)sender;
- (IBAction)onSecondTimeAM:(id)sender;
- (IBAction)onSecondTimePM:(id)sender;
- (IBAction)onThirdTimeAM:(id)sender;
- (IBAction)onThirdTimePM:(id)sender;
- (IBAction)onNextButton:(id)sender;
- (IBAction)onTimeButton:(id)sender;



@end
