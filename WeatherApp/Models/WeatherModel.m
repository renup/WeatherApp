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
        
        NSDate *date = [self utcToLocalTime:[NSDate dateWithTimeIntervalSince1970:[dateDictionary[@"dt"] doubleValue]]];
        
        self.day = [self dateToString:date];
        
        NSArray *weatherArray = dateDictionary[@"weather"];
        if (weatherArray.count > 0) {
            NSDictionary *dict = [weatherArray firstObject];
            self.icon = dict[@"icon"];
            self.weatherIconURL = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@%@", dict[@"icon"], @".png"];
        }
        
        NSDictionary *temperatureDict = dateDictionary[@"temp"];
        id temperature = temperatureDict[@"day"];
        if (temperature != nil) {
            self.temperature = [temperature description];
        }
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

-(NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE, MMMM d";
    return [dateFormatter stringFromDate:date];
}

@end
