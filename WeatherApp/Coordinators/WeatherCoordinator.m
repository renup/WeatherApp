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
    __weak WeatherCoordinator *weakSelf = self;
        [processor fetchWheatherData:^(NSData * _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error while fetching");
            } else {
                [self processWeatherData:result];
            }
        }];
}

-(void)processWeatherData:(NSData *)data {
    //parse out the json data
    NSError* error;
    NSDictionary* jsonDictionary = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    NSDictionary *cityDict = jsonDictionary[@"city"];
    self.cityName = cityDict[@"name"];
    NSArray *listArray = jsonDictionary[@"list"];
    
    NSMutableArray *daysForcastArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *day in listArray) {
        WeatherModel *dayWeather = [[WeatherModel alloc] initWithDictionary:day];
        [daysForcastArray addObject:dayWeather];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.weatherVC.daysForcastArray = daysForcastArray;
        [self.weatherVC refreshTableView];
    });
   
}

@end
