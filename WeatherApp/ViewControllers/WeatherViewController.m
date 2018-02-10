//
//  ViewController.m
//  WeatherApp
//
//  Created by Renu Punjabi on 2/9/18.
//  Copyright © 2018 Renu Punjabi. All rights reserved.
//

#import "WeatherViewController.h"
#import "APIProcessor.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    APIProcessor *processor = [[APIProcessor alloc] init];
    
    [processor fetchWheatherData:^(NSData * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error while fetching");
        } else {
            NSLog(@"found data = %@", result);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
