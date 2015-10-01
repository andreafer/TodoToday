//
//  AddFutureEventViewController.h
//  TodoToday
//
//  Created by HongYun on 3/6/15.
//  Copyright (c) 2015 Shenyang Damy Infotec Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface AddFutureEventViewController : SuperViewController <UITextFieldDelegate>
{
    
}
//@property (nonatomic) NSNumber *bIsFutureEvent;
@property (weak, nonatomic) IBOutlet UITextField *txtTodoContent;
//@property (weak, nonatomic) IBOutlet UILabel *lblEventType;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;


@end
