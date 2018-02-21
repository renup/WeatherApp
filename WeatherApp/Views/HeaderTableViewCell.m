//
//  HeaderTableViewCell.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/21/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.contentView.layer setBorderWidth:2.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
