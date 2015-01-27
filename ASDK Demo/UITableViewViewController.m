//
//  UITableViewViewController.m
//  ASDK Demo
//
//  Created by Kai Schaller on 1/15/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import "UITableViewViewController.h"
#import "MurrayCell.h"

static const CGFloat kNumberOfRows = 20;

@interface UITableViewViewController ()

@property (strong, nonatomic) NSArray *placeholders;
@property (strong, nonatomic) NSArray *imageSizes;

@end

@implementation UITableViewViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Generate slightly random sizes for placeholder images.
    NSMutableArray *imageSizes = [NSMutableArray arrayWithCapacity:kNumberOfRows];
    for (NSInteger i = 0; i < kNumberOfRows; i++) {
        u_int32_t deltaX = arc4random_uniform(10) - 5;
        u_int32_t deltaY = arc4random_uniform(10) - 5;
        CGSize size = CGSizeMake(350 + 2 * deltaX, 350 + 4 * deltaY);
        
        [imageSizes addObject:[NSValue valueWithCGSize:size]];
    }
    self.imageSizes = imageSizes;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memory warning");
}

#pragma mark - Utility

- (NSDictionary *)textStyle {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.paragraphSpacing = 0.5 * font.lineHeight;
    style.hyphenationFactor = 1;
    
    return @{ NSFontAttributeName: font,
              NSParagraphStyleAttributeName: style };
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MurrayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MurrayCell"];

    NSValue *sizeValue = self.imageSizes[indexPath.row];
    CGSize size = sizeValue.CGSizeValue;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://fillmurray.com/%zd/%zd", (NSInteger)roundl(size.width), (NSInteger)roundl(size.height)]];
    
    UIImageView *imageView = cell.murrayImageView;
    imageView.image = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
    
    return cell;
};

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100 + arc4random_uniform(200); // will return values between 100 and 300
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfRows;
}

#pragma mark - Table view delegate

@end
