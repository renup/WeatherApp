//
//  ImageDownloader.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/11/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDownloader : NSObject
typedef void(^completionBlock)(UIImage * _Nullable image, NSError * _Nullable error);

+ (ImageDownloader * _Nonnull)sharedDownloader;

- (void)downloadImage:(NSString * _Nonnull)imageURLString forIcon:(NSString * _Nonnull)icon completionHandler:(void(^ _Nullable)(UIImage * _Nullable image, NSError * _Nullable error))callback;

- (UIImage * _Nullable)imageFromDiskForIcon:(NSString * _Nullable)UrlString;

- (void)getImage:(NSString *)imageName completionHandler:(completionBlock _Nonnull)callback;

@end
