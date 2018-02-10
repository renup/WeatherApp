//
//  WeatherCoordinator.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherCoordinator.h"
#import "WeatherViewController.h"

@interface WeatherCoordinator()
@property(nonatomic, strong) UINavigationController *navigationVC;
@property(nonatomic, strong)WeatherViewController *weatherVC;
@end

@implementation WeatherCoordinator

- (WeatherCoordinator *)initWithViewController:(UINavigationController *)navigationVC {
    self.navigationVC = navigationVC;
    return self;
}

- (void)start {
    self.weatherVC = self.navigationVC.viewControllers.firstObject;
    NSLog(@"inside weather coordinator");
}
@end
