//
//  TemperatureHelper.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/21/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemperatureHelper : NSObject

+ (double)convertFromKelvinToCelcius:(double)kelvin;
+ (double)celciusToFahrenhiet:(double)celcius;
+ (double)fahrenhietToCelcius:(double) fahrenhiet;

@end
