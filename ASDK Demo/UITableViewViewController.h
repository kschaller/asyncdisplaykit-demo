//
//  UITableViewViewController.h
//  ASDK Demo
//
//  Created by Kai Schaller on 1/15/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
