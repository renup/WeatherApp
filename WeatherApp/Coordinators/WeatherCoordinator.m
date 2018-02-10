//
//  WeatherCoordinator.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherCoordinator.h"
#import "WeatherViewController.h"
#import "APIProcessor.h"

@interface WeatherCoordinator()
@property(nonatomic, strong) UINavigationController *navigationVC;
@property(nonatomic, strong)WeatherViewController *weatherVC;
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
    processor = [APIProcessor sharedProcessor];
    
    [processor fetchWheatherData:^(NSData * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error while fetching");
        } else {
            NSLog(@"found data = %@", result);
        }
    }];}
@end
