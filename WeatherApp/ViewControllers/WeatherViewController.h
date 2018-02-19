//
//  ViewController.h
//  WeatherApp
//
//  Created by Renu Punjabi on 2/9/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeatherViewControllerDelegate <NSObject>

@end

@interface WeatherViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray *daysForcastArray;
@property(nonatomic, weak)id <WeatherViewControllerDelegate> delegate;
- (void)refreshTableView;

@end

