//
//  MurrayNode.m
//  ASDK Demo
//
//  Created by Kai Schaller on 1/27/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import "MurrayNode.h"
#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@interface MurrayNode ()

@property (nonatomic) CGSize murraySize;
@property (strong, nonatomic) ASNetworkImageNode *imageNode;

@end

@implementation MurrayNode

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    CGFloat requiredHeight = 100 + arc4random_uniform(200);

    return CGSizeMake(constrainedSize.width, requiredHeight);
}

- (instancetype)initWithMurrayOfSize:(CGSize)size {
    if (!(self = [super init])) {
        return nil;
    }
    
    _murraySize = size;
    
    // Images courtesy of FillMurray.com, with a background color serving as a placholder.
    _imageNode = [[ASNetworkImageNode alloc] init];
    _imageNode.backgroundColor = [UIColor lightGrayColor];
    _imageNode.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.fillmurray.com/%zd/%zd", (NSInteger)roundl(_murraySize.width), (NSInteger)roundl(_murraySize.height)]];
    [self addSubnode:_imageNode];
    
    return self;
}

- (void)layout {
    _imageNode.frame = CGRectMake(0, 0, 320, 320);
}

@end
