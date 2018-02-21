//
//  DateHelper.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/21/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

/**
 * Takes a unic UTC timestamp and converts it
 * to an NSDate formatted in the device’s local
 * timezone
 *
 * @param date Date to be converted
 *
 * @return Converted date
 */
+ (NSDate *)utcToLocalTime:(NSDate*)date {
    NSTimeZone *currentTimeZone =
    [NSTimeZone defaultTimeZone];
    NSInteger secondsOffset =
    [currentTimeZone secondsFromGMTForDate:date];
    return [NSDate dateWithTimeInterval:
            secondsOffset sinceDate:date];
}

+ (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE, MMM d";
    return [dateFormatter stringFromDate:date];
}

@end
