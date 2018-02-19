//
//  APIProcessor.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIProcessor : NSObject
typedef void(^finishBlock)(NSData * _Nullable result, NSError * _Nullable error);

+(_Nonnull id)sharedProcessor;

-(void)fetchWheatherData:(void(^_Nonnull)(NSData * _Nullable result, NSError * _Nullable error))callback;

- (void)downloadImage:(NSString * _Nonnull)urlString completionHandler:(finishBlock _Nonnull)callback;

- (void)fetchCurrentWeatherData:(finishBlock _Nonnull)callback;

@end
