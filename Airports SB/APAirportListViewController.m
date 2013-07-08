//
//  APAirportListViewController.m
//  Airports SB
//
//  Created by sodas on 10/8/12.
//  Copyright (c) 2012 NTU Mobile HCI Lab. All rights reserved.
//

#import "APAirportListViewController.h"
#import "APDetailViewController.h"
#import "APAirportListCell.h"
#import "APDataSource.h"

@interface APAirportListViewController ()

@end

@implementation APAirportListViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[APDataSource sharedDataSource] arrayWithCountries] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[APDataSource sharedDataSource] arrayWithCountries][section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *country = [[APDataSource sharedDataSource] arrayWithCountries][section];
    return [[[APDataSource sharedDataSource] arrayWithAirportInCountries:country] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Fetch airport data by index path from city list
    NSDictionary *airport = [[APDataSource sharedDataSource] dictionaryWithAirportAtIndexPath:indexPath];
    
    // Assign values to views in cell
    APAirportListCell *airportCell = (APAirportListCell *)cell;
    airportCell.airportName.text = airport[APDataSourceDictKeyName];
    airportCell.iataName.text = airport[APDataSourceDictKeyIATA];
    
    // Another simple way to find views by their tags, if tags of views are set.
    //UILabel *airportNameLabel = (UILabel *)[cell viewWithTag:1001];
    //UILabel *iataLabel = (UILabel *)[cell viewWithTag:1002];
    //airportNameLabel.text = airport[APDataSourceDictKeyShortName];
    //iataLabel.text = airport[APDataSourceDictKeyIATA];
    
    return cell;
}

#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        // Fetch data by index path from data source
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *airport = [[APDataSource sharedDataSource] dictionaryWithAirportAtIndexPath:indexPath];
        
        // Feed data to the destination of the segue
        APDetailViewController *detailPage = segue.destinationViewController;
        detailPage.airport = airport;
    }
}

@end
