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
            double farenhiet = [self convertFromKelvinToCelcius:[temperature doubleValue]];
            self.temperature = [NSString stringWithFormat:@"%.2f", farenhiet];
        }
    }
    return self;
}

- (WeatherModel *)initWithCurrentWeatherDictionary:(NSDictionary *)currentWeatherDictionary {
    if (self = [super init]) {
        NSDictionary *mainDict = currentWeatherDictionary[@"main"];
        id temprature = mainDict[@"temp"];
        double farenhiet = [self convertFromKelvinToCelcius:[temprature doubleValue]];
        self.temperature = [NSString stringWithFormat:@"%.2f", farenhiet];
        
        NSArray *weatherArray = currentWeatherDictionary[@"weather"];
        if (weatherArray.count > 0) {
            NSDictionary *dict = [weatherArray firstObject];
            self.icon = dict[@"icon"];
            self.weatherIconURL = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@%@", dict[@"icon"], @".png"];
        }

    }
    return self;
}

//TODO: check from documentation about the unit of temperature.
- (double)convertFromKelvinToCelcius:(double)kelvin {
    return  (kelvin - 273.15);
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
    dateFormatter.dateFormat = @"EEEE, MMM d";
    return [dateFormatter stringFromDate:date];
}

@end
