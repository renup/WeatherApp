//
//  ImageDownloader.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/11/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "ImageDownloader.h"
#import "APIProcessor.h"

@implementation ImageDownloader

APIProcessor *sharedProcessor;

+ (ImageDownloader * _Nonnull)sharedDownloader {
    static ImageDownloader *sharedImageDownloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedImageDownloader = [[ImageDownloader alloc] init];
    });
    return sharedImageDownloader;
}


- (void)downloadImage:(NSString * _Nonnull)imageURLString  completionHandler:(void(^ _Nullable)(UIImage * _Nullable image, NSError * _Nullable error))callback {
    sharedProcessor = [APIProcessor sharedProcessor];
    
    [sharedProcessor downloadImage:imageURLString completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data != nil) {
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self saveImage:image forUrl:imageURLString];
                callback(image, nil);
                return;
            });
            callback(nil, error);
        }
    }];
    
}

- (void)saveImage:(UIImage *)image forUrl:(NSString *)imageURLString {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:imageURLString];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

- (UIImage * _Nullable)imageFromDiskForIcon:(NSString * _Nullable)UrlString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (UrlString != nil) {
        NSString* path = [documentsDirectory stringByAppendingPathComponent:UrlString];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    return nil;
}

@end
