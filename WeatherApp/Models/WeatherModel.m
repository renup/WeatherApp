//
//  WeatherModel.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherModel.h"
#import "TemperatureHelper.h"
#import "DateHelper.h"

@implementation WeatherModel

- (WeatherModel *)initWithDictionary:(NSDictionary *)dateDictionary {
    if (self = [super init]) {
        
        NSDate *date = [DateHelper utcToLocalTime:[NSDate dateWithTimeIntervalSince1970:[dateDictionary[@"dt"] doubleValue]]];
        
        self.day = [DateHelper dateToString:date];
        
        NSArray *weatherArray = dateDictionary[@"weather"];
        if (weatherArray.count > 0) {
            NSDictionary *dict = [weatherArray firstObject];
            self.icon = dict[@"icon"];
        }
        
        NSDictionary *temperatureDict = dateDictionary[@"temp"];
        id temperature;
        if (temperatureDict.count > 0) {
            temperature = temperatureDict[@"day"];
        } else {
            temperatureDict = dateDictionary[@"main"];
            temperature = temperatureDict[@"temp"];
        }
        if (temperature != nil) {
            double farenhiet = [TemperatureHelper convertFromKelvinToCelcius:[temperature doubleValue]];
            self.temperature = [NSString stringWithFormat:@"%.2f%@",farenhiet, @"\u00B0"];
        }
    }
    return self;
}

@end
