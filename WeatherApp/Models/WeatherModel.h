//
//  WeatherModel.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property(nonatomic, strong)NSString *weatherIconURL;
@property(nonatomic, strong)NSNumber *temperature;
@property(nonatomic, strong)NSDate *date;

- (WeatherModel *)initWithDictionary:(NSDictionary *)dateDictionary;

@end
