//
//  APIProcessor.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "APIProcessor.h"
#import "AFNetworking.h"

@implementation APIProcessor

NSString *baseURL = @"http://api.openweathermap.org/data/2.5/forecast/daily?q=Sunnyvale&mode=json&units=metric&cnt=16&appid=adb4503a31093fed77c0a5f39d4c512b";

-(void)fetchWheatherData:(void(^_Nonnull)(NSData * _Nullable result, NSError * _Nullable error))callback {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        } else {
            callback(responseObject, nil);
        }
    }];

//    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            callback(nil, error);
//        } else {
//            callback(responseObject, nil);
//        }
//    }];
    [dataTask resume];
}

@end
