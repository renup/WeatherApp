//
//  AppCoordinator.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "AppCoordinator.h"
#import "WeatherCoordinator.h"

@interface AppCoordinator()
@property(nonatomic, strong) UINavigationController *navigationVC;
@end

@implementation AppCoordinator

- (AppCoordinator *)initWithViewController:(UINavigationController *)navigationVC {
    self.navigationVC = navigationVC;
    return self;
}

- (void)start {
    WeatherCoordinator *weatherCoordinator = [[WeatherCoordinator alloc] initWithViewController:self.navigationVC];
    [weatherCoordinator start];
}

@end
