//
//  Common.h
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <AdSupport/AdSupport.h>



#define MOVE_FROM_RIGHT     CATransition *animation = [CATransition animation]; \
                            [animation setDuration:0.3]; \
                            [animation setType:kCATransitionPush]; \
                            [animation setSubtype:kCATransitionFromRight]; \
                            [animation setTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]]; \
                            [[self.view.superview layer] addAnimation:animation forKey:@"SwitchToView"];

#define MOVE_FROM_LEFT      CATransition *animation = [CATransition animation]; \
                            [animation setDuration:0.3]; \
                            [animation setType:kCATransitionPush]; \
                            [animation setSubtype:kCATransitionFromLeft]; \
                            [animation setTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]]; \
                            [[self.view.superview layer] addAnimation:animation forKey:@"SwitchToView"];

#define SHOW_VIEW(ctrl)     MOVE_FROM_RIGHT \
                            [self presentViewController:ctrl animated:NO completion:nil];

#define SHOW_VIEW_IN_CELL(parent, ctrl)  \
                            CATransition *animation = [CATransition animation]; \
                            [animation setDuration:0.3]; \
                            [animation setType:kCATransitionPush]; \
                            [animation setSubtype:kCATransitionFromRight]; \
                            [animation setTimingFunction:[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]]; \
                            [[parent.view.superview layer] addAnimation:animation forKey:@"SwitchToView"]; \
                            [parent presentViewController:ctrl animated:NO completion:nil];


#define BACK_VIEW           MOVE_FROM_LEFT \
                            [self dismissViewControllerAnimated:NO completion:nil];

#define BACKGROUND_TEST_NETWORK_RETURN    if ([CommManager hasConnectivity] == NO) { \
                                                return; \
                                            }


#ifdef DEBUG// 如果有DEBUG这个宏就编译下面一句代码
#define MyLog(...) NSLog(__VA_ARGS__)
#else // 如果没有DEBUG这个宏就编译下面一句代码
#define MyLog(...)
#endif

#define DEF_IMAGE           [UIImage imageNamed:@"def_image.png"]


typedef NS_ENUM(NSInteger, DEVICE_KIND) {
    IPHONE4= 1,
    IPHONE5,
    IPAD,
};

@interface GlobalFunc : NSObject {
}

+ (BOOL) isOverIOS8;
+ (BOOL) isOverIOS7;
+ (float)getSystemVersion;

+ (void) makeErrorWindow : (NSString *)content TopOffset:(NSInteger)topOffset BottomOffset:(NSInteger)bottomOffset View:(UIView *)view;


+ (NSString *) getCurTime : (NSString*)fmt;
+ (NSString *) convertDateToString : (NSDate *)date fmt:(NSString *)fmt;
+ (NSDate *) convertStringToDate : (NSString *)date fmt:(NSString *)fmt;
+ (NSDateComponents *) convertNSDateToNSDateComponents : (NSDate *)date;

+ (NSInteger) phoneType;
+ (NSString *) appNameAndVersionNumberDisplayString;

@end
