//
//  AppCoordinator.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//@class WeatherViewController;
@interface AppCoordinator : NSObject

- (AppCoordinator *)initWithViewController:(UINavigationController *)navigationVC;

- (void)start;

@end
