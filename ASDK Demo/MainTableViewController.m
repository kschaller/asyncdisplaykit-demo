//
//  MainTableViewController.m
//  ASDK Demo
//
//  Created by Kai Schaller on 1/15/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    UILabel *subtitle = (UILabel *)[cell viewWithTag:2];

    if (indexPath.row == 0) {
        title.text = @"UITableView";
        subtitle.text = @"Old and busted";
    } else {
        title.text = @"ASTableView";
        subtitle.text = @"The new hotness";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"UITableViewSegue" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"ASTableViewSegue" sender:nil];
    }
}

@end
