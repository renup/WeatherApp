//
//  APIProcessor.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "APIProcessor.h"

@implementation APIProcessor

typedef void(^finishBlock)(NSData * _Nullable result, NSError * _Nullable error);

NSString *baseURL = @"http://api.openweathermap.org/data/2.5/";
NSString *appId = @"adb4503a31093fed77c0a5f39d4c512b";
//NSString *baseURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?q=Sunnyvale&mode=json&units=metric&cnt=16&appid=adb4503a31093fed77c0a5f39d4c512b";
//let _ = "http://api.openweathermap.org/data/2.5/weather?q=California,us&appid=adb4503a31093fed77c0a5f39d4c512b";


+(id)sharedProcessor {
    static APIProcessor *sharedProcessor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProcessor = [[APIProcessor alloc] init];
    });
    return sharedProcessor;
}

-(void)fetchWheatherData:(finishBlock)callback {
    NSString *weatherURLStr = [NSString stringWithFormat:@"%@%@%@", baseURL, @"forecast/daily?q=Sunnyvale&mode=json&units=metric&cnt=16&appid=", appId];

    [self executeRequest:weatherURLStr withBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        } else {
            callback(data, nil);
        }
    }];
}

- (void)fetchCurrentWeatherData:(finishBlock)callback {
    NSString *currentWeatherURLStr = [NSString stringWithFormat:@"%@%@%@", baseURL, @"weather?q=California,us&appid=", appId];
    
    [self executeRequest:currentWeatherURLStr withBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        } else {
            callback(data, nil);
        }
    }];
}

- (void)executeRequest:(NSString *)urlStr withBlock:(void(^)(NSData * _Nullable data, NSError * _Nullable error))completionBlock {
    NSURL *url = [NSURL URLWithString: urlStr];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(nil, error);
        } else {
            completionBlock(data, nil);
        }
    }];
    [dataTask resume];
}

- (void)downloadImage:(NSString * _Nonnull)urlString completionHandler:(void (^ _Nullable)(NSData * _Nullable data, NSError * _Nullable error))callback {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"image download complete");
    callback(data, nil);
}

@end
