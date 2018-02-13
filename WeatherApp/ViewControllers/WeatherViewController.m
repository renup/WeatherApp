//
//  ViewController.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/9/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherTableViewCell.h"

@interface WeatherViewController ()


@end

@implementation WeatherViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.daysForcastArray = [[NSArray alloc] init];
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


@end
