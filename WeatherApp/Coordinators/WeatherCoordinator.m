//
//  WeatherCoordinator.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherCoordinator.h"
#import "APIProcessor.h"
#import "WeatherModel.h"

@interface WeatherCoordinator()
@property(nonatomic, strong) UINavigationController *navigationVC;
@property(nonatomic, strong)WeatherViewController *weatherVC;
@property(nonatomic, strong)NSString *cityName;

@end

@implementation WeatherCoordinator 

APIProcessor *processor;

- (WeatherCoordinator *)initWithViewController:(UINavigationController *)navigationVC {
    if (self = [super init]) {
        self.navigationVC = navigationVC;
    }
    return self;
}

- (void)start {
    self.weatherVC = self.navigationVC.viewControllers.firstObject;
    self.weatherVC.delegate = self;
    processor = [APIProcessor sharedProcessor];
   
    [processor fetchCurrentWeatherData:^(NSData * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error while fetching");
        } else {
            NSLog(@"current whether data");
            [self processCurrentWeatherData:result];
        }
    }];
    
    [processor fetchWheatherData:^(NSData * _Nullable result, NSError * _Nullable error) {
            if (error) {
            NSLog(@"error while fetching");
        } else {
            [self processWeatherData:result];
        }
    }];
}

- (void)processCurrentWeatherData:(NSData *)data {
    NSDictionary* jsonDictionary = [self serializeData:data];
    if (jsonDictionary != nil) {
        WeatherModel *weather = [[WeatherModel alloc] initWithDictionary:jsonDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.weatherVC.daysForcastArray addObject: weather];
        });
    }
}

-(void)processWeatherData:(NSData *)data {
    NSDictionary* jsonDictionary = [self serializeData:data];
    if (jsonDictionary != nil) {
        NSArray *listArray = jsonDictionary[@"list"];
        
        NSMutableArray *daysForcastArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *day in listArray) {
            WeatherModel *dayWeather = [[WeatherModel alloc] initWithDictionary:day];
            [daysForcastArray addObject:dayWeather];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.weatherVC.daysForcastArray addObjectsFromArray: daysForcastArray];
            [self.weatherVC refreshTableView];
        });
    }
}

- (NSDictionary *)serializeData:(NSData *)data {
    //parse out the json data
    NSError* error;
    NSDictionary* jsonDictionary = [NSJSONSerialization
                                    JSONObjectWithData:data
                                    options:kNilOptions
                                    error:&error];
    if (!jsonDictionary) {
        NSLog(@"error while serializing data from server = %@", error);
        return nil;
    }
    return jsonDictionary;
}

@end
