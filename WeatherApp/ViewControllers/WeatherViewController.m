//
//  ViewController.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/9/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherTableViewCell.h"
#import "ImageDownloader.h"
#import "TemperatureHelper.h"
#import "HeaderTableViewCell.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.daysForcastArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTableView {
    [self.tableView reloadData];
}

//MARK: UITableViewDataSourceMethods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.daysForcastArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell"];
    if (self.daysForcastArray.count > 0) {
        [cell configureCellFor:indexPath forWeatherModel:self.daysForcastArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.backgroundView.backgroundColor = [header.backgroundView.backgroundColor colorWithAlphaComponent:1];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    
    if (self.daysForcastArray.count > 0) {
        WeatherModel *weather = self.daysForcastArray.firstObject;
        headerCell.headerLabel.text = weather.temperature;
        ImageDownloader *downloader = [ImageDownloader sharedDownloader];
        [downloader getImage:weather.icon completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    headerCell.headerImageView.image = image;
                });
            }
        }];
    }
    return headerCell;
}



//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //The view for the header
//    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
//
////    //Set a custom border
//    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
//    headerView.layer.borderWidth = 1.0;
//
//    //Add a label
//    UILabel* headerLabel = [[UILabel alloc] init];
//    headerLabel.frame = CGRectMake(tableView.frame.size.width/2 + 15, 10, 150, 90);
//    headerLabel.backgroundColor = [UIColor orangeColor];
//    headerLabel.textColor = [UIColor blackColor];
//    headerLabel.font = [UIFont boldSystemFontOfSize:25.0];
//    NSLog(@"%f", CGRectGetMinX(headerLabel.frame) - 150);
//
//    //Add ImageView
//    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headerLabel.frame) - 180, CGRectGetMinY(headerLabel.frame), headerLabel.frame.size.height, headerLabel.frame.size.height)];
//    iconImageView.image = [UIImage imageNamed:@"weather.png"];
//
//    if (self.daysForcastArray.count > 0) {
//        WeatherModel *weather = self.daysForcastArray[0];
//        headerLabel.text = weather.temperature;
//        ImageDownloader *downloader = [ImageDownloader sharedDownloader];
//        [downloader getImage:weather.icon completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
//            if (!error) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    iconImageView.image = image;
//                });
//            }
//        }];
//    }
//    headerLabel.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:headerLabel];
//    [headerView addSubview:iconImageView];
//    return headerView;
//}

- (IBAction)celciusFahrenheitSegmentedButtonClicked:(id)sender {
    UISegmentedControl *segmentButton = (UISegmentedControl *)sender;
    
    if (segmentButton.selectedSegmentIndex == 0) {
        for (WeatherModel *weather in self.daysForcastArray) {
            weather.temperature = [NSString stringWithFormat:@"%.2f", [TemperatureHelper celciusToFahrenhiet:[weather.temperature doubleValue]]];
        }
    } else {
        for (WeatherModel *weather in self.daysForcastArray) {
            weather.temperature = [NSString stringWithFormat:@"%.2f", [TemperatureHelper fahrenhietToCelcius:[weather.temperature doubleValue]]];
        }
    }
    [self.tableView reloadData];
}

@end
