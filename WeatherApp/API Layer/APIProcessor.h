//
//  APIProcessor.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIProcessor : NSObject

+(id)sharedProcessor;

-(void)fetchWheatherData:(void(^_Nonnull)(NSData * _Nullable result, NSError * _Nullable error))callback;

@end
