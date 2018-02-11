//
//  ImageDownloader.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/11/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject

- (void)downloadAndCacheImage:(NSString *)imageURLString;

@end
