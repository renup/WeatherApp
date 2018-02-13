//
//  WeatherTableViewCell.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellFor:(NSIndexPath *)indexPath forWeatherModel:(WeatherModel *)weather {
    self.temperatureLabel.text = weather.temperature;
    self.dayLabel.text = weather.day;
}

@end
