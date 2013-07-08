//
//  APDetailViewController.m
//  Airports SB
//
//  Created by sodas on 10/8/12.
//  Copyright (c) 2012 NTU Mobile HCI Lab. All rights reserved.
//

#import "APDetailViewController.h"
#import "APDataSource.h"

@interface APDetailViewController ()

@end

@implementation APDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.iataName.text = self.title = self.airport[APDataSourceDictKeyIATA];
    self.airportName.text = self.airport[APDataSourceDictKeyName];
    self.country.text = self.airport[APDataSourceDictKeyCountry];
    self.city.text = self.airport[APDataSourceDictKeyCity];
    
    UIImage *image = [UIImage imageNamed:self.airport[APDataSourceDictKeyImage]];
    self.imageView.image = image;
}

@end
