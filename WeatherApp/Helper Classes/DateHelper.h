//
//  DateHelper.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/21/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+ (NSDate *)utcToLocalTime:(NSDate*)date;
+ (NSString *)dateToString:(NSDate *)date;

@end
