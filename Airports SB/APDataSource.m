//
//  APDataSource.m
//  Airports
//
//  Created by sodas on 10/6/12.
//  Copyright (c) 2012 NTU Mobile HCI Lab. All rights reserved.
//

#import "APDataSource.h"

// Cache Keys
static NSString *APDataSourceCacheKeyCountries = @"APDataSource.Cache.Countries";
static NSString *APDataSourceCacheKeyAirports = @"APDataSource.Cache.%@.Airports";

// Dictionary Keys
NSString * const APDataSourceDictKeyIATA = @"IATA";
NSString * const APDataSourceDictKeyName = @"Airport";
NSString * const APDataSourceDictKeyShortName = @"ShortName";
NSString * const APDataSourceDictKeyCountry = @"Country";
NSString * const APDataSourceDictKeyCity = @"ServedCity";
NSString * const APDataSourceDictKeyImage = @"Image";

@interface APDataSource ()

@end

@implementation APDataSource

#pragma mark -
#pragma mark Object Lifecycle

+ (APDataSource *)sharedDataSource {
    static dispatch_once_t once;
    static APDataSource *sharedDataSource;
    dispatch_once(&once, ^ {
        sharedDataSource = [[self alloc] init];
    });
    return sharedDataSource;
}

- (id)init {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"airports" ofType:@"plist"];
        airportList = [NSArray arrayWithContentsOfFile:path];
        
        cache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark Interfaces

- (void)refresh {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"airports" ofType:@"plist"];
    airportList = [NSArray arrayWithContentsOfFile:path];
    
    [self cleanCache];
}

- (void)cleanCache {
    [cache removeAllObjects];
}

- (NSArray *)arrayWithCountries {
    NSArray *countries = [cache objectForKey:APDataSourceCacheKeyCountries];
    
    if (!countries) {
        // Save countries into a set (remove duplicates result).
        NSMutableSet *countriesSet = [NSMutableSet set];
        for (NSDictionary *airport in airportList)
            [countriesSet addObject:airport[APDataSourceDictKeyCountry]];
        
        // Convert set to array and sort the array.
        countries = [[countriesSet allObjects] sortedArrayUsingComparator:
                     ^NSComparisonResult(id obj1, id obj2) {
                         return [obj1 compare:obj2];
                     }];
        
        // Save the result into cache
        [cache setObject:countries forKey:APDataSourceCacheKeyCountries];
    }
    
    return countries;
}

- (NSArray *)arrayWithAirportInCountries:(NSString *)country {
    NSString *cacheKey = [NSString stringWithFormat:APDataSourceCacheKeyAirports, country];
    NSArray *resultAirports = [cache objectForKey:cacheKey];
    
    if (!resultAirports) {
        // Filter array
        resultAirports = [airportList filteredArrayUsingPredicate:
                          [NSPredicate predicateWithBlock:
                           ^BOOL(id evaluatedObject, NSDictionary *bindings) {
                               NSDictionary *airport = (NSDictionary *)evaluatedObject;
                               return [airport[APDataSourceDictKeyCountry] isEqualToString:country];
                           }]];
        // Sort array
        resultAirports = [resultAirports sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1[APDataSourceDictKeyIATA] compare:obj2[APDataSourceDictKeyIATA]];
        }];
        
        // Save the result into cache
        [cache setObject:resultAirports forKey:cacheKey];
    }
    
    return resultAirports;
}

- (NSDictionary *)dictionaryWithAirportAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    NSString *country = [self arrayWithCountries][section];
    NSDictionary *airport = [self arrayWithAirportInCountries:country][row];
    return airport;
}

@end
