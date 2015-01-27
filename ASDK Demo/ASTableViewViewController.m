//
//  ASTableViewViewController.m
//  ASDK Demo
//
//  Disclaimer: Code heavily borrowed from https://github.com/facebook/AsyncDisplayKit/tree/master/examples/Kittens
//
//  Created by Kai Schaller on 1/15/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import "ASTableViewViewController.h"
#import "MurrayNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

static const NSInteger kNumberOfRows = 20;

@interface ASTableViewViewController () <ASTableViewDataSource, ASTableViewDelegate>

@property (strong, nonatomic) ASTableView *tableView;
@property (strong, nonatomic) NSArray *imageSizes;

@end

@implementation ASTableViewViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ASTableView *tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.asyncDataSource = self;
    tableView.asyncDelegate = self;
    self.tableView = tableView;
    
    // Generate slightly random sizes for placeholder images.
    NSMutableArray *imageSizes = [NSMutableArray arrayWithCapacity:kNumberOfRows];
    for (NSInteger i = 0; i < kNumberOfRows; i++) {
        u_int32_t deltaX = arc4random_uniform(10) - 5;
        u_int32_t deltaY = arc4random_uniform(10) - 5;
        CGSize size = CGSizeMake(350 + 2 * deltaX, 350 + 4 * deltaY);
        
        [imageSizes addObject:[NSValue valueWithCGSize:size]];
    }
    self.imageSizes = imageSizes;

    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.bounds;
}

#pragma mark - ASTableViewDataSource

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSValue *size = self.imageSizes[indexPath.row];
    MurrayNode *node = [[MurrayNode alloc] initWithMurrayOfSize:size.CGSizeValue];
    
    return node;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.imageSizes count];
}

#pragma mark - ASTableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
