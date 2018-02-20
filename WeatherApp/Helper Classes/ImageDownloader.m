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

- (void)getImage:(NSString *)imageName completionHandler:(completionBlock _Nonnull)callback {
    UIImage *img = [self imageFromDiskForIcon:imageName];

    if (img != nil) {
        callback(img, nil);
    } else {
        NSString *urlStr = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@%@", imageName, @".png"];
        [self downloadImage:urlStr forIcon:imageName completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
            if (error == nil) {
                callback(image, nil);
                return ;
            }
            callback(nil, error);
        }];
    }
}

- (void)downloadImage:(NSString * _Nonnull)imageURLString forIcon:(NSString * _Nonnull)icon completionHandler:(void(^ _Nullable)(UIImage * _Nullable image, NSError * _Nullable error))callback {
    sharedProcessor = [APIProcessor sharedProcessor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [sharedProcessor downloadImage:imageURLString completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (data != nil) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:data];

                    [self saveImage:image forIcon:icon];
                    callback(image, nil);
                    return;
                });
                callback(nil, error);
            }
        }];
    });
}

- (void)saveImage:(UIImage *)image forIcon:(NSString *)icon {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:icon];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

- (UIImage * _Nullable)imageFromDiskForIcon:(NSString * _Nullable)icon
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (icon != nil) {
        NSString* path = [documentsDirectory stringByAppendingPathComponent:icon];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    return nil;
}

@end
