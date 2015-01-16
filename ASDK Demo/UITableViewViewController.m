//
//  UITableViewViewController.m
//  ASDK Demo
//
//  Created by Kai Schaller on 1/15/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import "UITableViewViewController.h"

@interface UITableViewViewController ()

@end

@implementation UITableViewViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a UITableView and add it to the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memory warning");
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoCell"];
    }
    
    UIImage *photo = [UIImage imageNamed:@"0"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:photo];
    imageView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 200);
    [cell addSubview:imageView];
    
    return cell;
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

#pragma mark - Table view delegate

@end
