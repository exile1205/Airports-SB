//
//  APDataSource.h
//  Airports
//
//  Created by sodas on 10/6/12.
//  Copyright (c) 2012 NTU Mobile HCI Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const APDataSourceDictKeyIATA;
extern NSString * const APDataSourceDictKeyName;
extern NSString * const APDataSourceDictKeyShortName;
extern NSString * const APDataSourceDictKeyCountry;
extern NSString * const APDataSourceDictKeyCity;
extern NSString * const APDataSourceDictKeyImage;

@interface APDataSource : NSObject {
    // Main data pool
    NSArray *airportList;
    // Cache data pool
    NSCache *cache;
}

+ (APDataSource *)sharedDataSource;

- (void)refresh;
- (void)cleanCache;
- (NSArray *)arrayWithCountries;
- (NSArray *)arrayWithAirportInCountries:(NSString *)country;
- (NSDictionary *)dictionaryWithAirportAtIndexPath:(NSIndexPath *)indexPath;

@end
