//
//  APAppDelegate.m
//  Airports SB
//
//  Created by sodas on 10/8/12.
//  Copyright (c) 2012 NTU Mobile HCI Lab. All rights reserved.
//

#import "APAppDelegate.h"
#import "APDataSource.h"

@implementation APAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[APDataSource sharedDataSource] cleanCache];
}

@end
