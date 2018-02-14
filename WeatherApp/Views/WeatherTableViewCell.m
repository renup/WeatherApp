//
//  WeatherTableViewCell.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherTableViewCell.h"
#import "ImageDownloader.h"

@implementation WeatherTableViewCell
ImageDownloader *sharedDownloader;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    sharedDownloader = [ImageDownloader sharedDownloader];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellFor:(NSIndexPath *)indexPath forWeatherModel:(WeatherModel *)weather {
    self.temperatureLabel.text = weather.temperature;
    self.dayLabel.text = weather.day;
    self.weatherIconImageView.image = [UIImage imageNamed:@"weather.png"];
    
    if (weather.icon != nil && weather.weatherIconURL != nil) {
        UIImage *img = [sharedDownloader imageFromDiskForIcon:weather.icon];
        
        if (img != nil) {
            self.weatherIconImageView.image = img;
        } else {
            [sharedDownloader downloadImage:weather.weatherIconURL forIcon:weather.icon completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
                if (error == nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.weatherIconImageView.image = image;
                    });
                }
            }];
        }
    }
   
    
}

@end
