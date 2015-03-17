//
//  Common.m
//  4S-C
//
//  Created by R CJ on 1/5/13.
//  Copyright (c) 2013 PIC. All rights reserved.
//

#import "GlobalFunc.h"
#import <CommonCrypto/CommonDigest.h>

// Common variables


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation GlobalFunc

+ (BOOL) isOverIOS7
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // code here
        return true;
    }
    
    return false;
}

+ (BOOL) isOverIOS8
{
	if ([self getSystemVersion] >= 8) {
		// code here
		return true;
	}
	
	return false;
}


+ (float)getSystemVersion
{
	return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void) makeErrorWindow : (NSString *)content TopOffset:(NSInteger)topOffset BottomOffset:(NSInteger)bottomOffset View:(UIView *)view
{
    CGRect rt = [view frame];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0., topOffset, rt.size.width, rt.size.height - topOffset - bottomOffset)];
    [imgView setImage:[UIImage imageNamed:@"bkError.png"]];

	UILabel * lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0., topOffset, rt.size.width, rt.size.height - topOffset - bottomOffset)];
    lblContent.backgroundColor = [UIColor clearColor];
    lblContent.textAlignment = NSTextAlignmentCenter;
    lblContent.text = content;

	[view addSubview:imgView];
    [view addSubview:lblContent];
}


+ (NSString*) getCurTime : (NSString*)fmt
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ( fmt == nil ) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [dateFormatter setDateFormat:fmt];
    }
    
    return [dateFormatter stringFromDate:currentDate];
}

+ (NSString *) convertDateToString : (NSDate *)date fmt:(NSString *)fmt
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    static NSLocale* en_US_POSIX = nil;
    if (en_US_POSIX == nil) {
        en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    [dateFormatter setLocale:en_US_POSIX];
    
	if ( fmt == nil ) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	} else {
		[dateFormatter setDateFormat:fmt];
	}
	
	return [dateFormatter stringFromDate:date];
}

+ (NSDate *) convertStringToDate : (NSString *)date fmt:(NSString *)fmt
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	if ( fmt == nil ) {
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	} else {
		[dateFormatter setDateFormat:fmt];
	}
	
	return [dateFormatter dateFromString:date];
}

+ (NSDateComponents *) convertNSDateToNSDateComponents : (NSDate *)date
{
	NSCalendar * calendar = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal;
	NSDateComponents * comps = [calendar components:unitFlags fromDate:date];
	
	return comps;
}

+ (NSInteger)phoneType
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height == 568) {
            return IPHONE5;
        }
        else {
            return IPHONE4;
        }
    }
    else {
        return IPAD;
    }
}

+ (NSString *)appNameAndVersionNumberDisplayString
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //NSString *appDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return majorVersion;
}


@end
