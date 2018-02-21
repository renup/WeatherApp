//
//  TemperatureHelper.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/21/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "TemperatureHelper.h"

@implementation TemperatureHelper

//TODO: check from documentation about the unit of temperature.
+ (double)convertFromKelvinToCelcius:(double)kelvin {
    return  (kelvin - 273.15);
}

+ (double)celciusToFahrenhiet:(double)celcius {
    return 1.8 * celcius + 32;
}

+ (double)fahrenhietToCelcius:(double) fahrenhiet {
    return ((fahrenhiet - 32) * 5)/9 ;
}

@end
