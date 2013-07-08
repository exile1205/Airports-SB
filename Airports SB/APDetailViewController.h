//
//  APDetailViewController.h
//  Airports SB
//
//  Created by sodas on 10/8/12.
//  Copyright (c) 2012 NTU Mobile HCI Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *airport;

@property (strong, nonatomic) IBOutlet UILabel *iataName;
@property (strong, nonatomic) IBOutlet UILabel *airportName;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
