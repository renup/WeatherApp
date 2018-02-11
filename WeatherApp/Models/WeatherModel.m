//
//  WeatherModel.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

- (WeatherModel *)initWithDictionary:(NSDictionary *)dateDictionary {
    if (self = [super init]) {
        
        self.date = [self utcToLocalTime:[NSDate dateWithTimeIntervalSince1970:[dateDictionary[@"dt"] doubleValue]]];
    }
    return self;
}

/**
 * Takes a unic UTC timestamp and converts it
 * to an NSDate formatted in the device’s local
 * timezone
 *
 * @param date Date to be converted
 *
 * @return Converted date
 */
-(NSDate *)utcToLocalTime:(NSDate*)date {
    NSTimeZone *currentTimeZone =
    [NSTimeZone defaultTimeZone];
    NSInteger secondsOffset =
    [currentTimeZone secondsFromGMTForDate:date];
    return [NSDate dateWithTimeInterval:
            secondsOffset sinceDate:date];
}

@end
