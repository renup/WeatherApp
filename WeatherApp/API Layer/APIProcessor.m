//
//  APIProcessor.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "APIProcessor.h"

@implementation APIProcessor

NSString *baseURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?q=Sunnyvale&mode=json&units=metric&cnt=16&appid=adb4503a31093fed77c0a5f39d4c512b";

-(void)fetchWheatherData:(NSString *)urlString completion:(void(^)(NSString *result))callback {
    
}

@end
