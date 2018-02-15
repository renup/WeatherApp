//
//  WeatherTableViewCell.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/10/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"

@interface WeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

- (void)configureCellFor:(NSIndexPath *)indexPath forWeatherModel:(WeatherModel *)weather;

@end
