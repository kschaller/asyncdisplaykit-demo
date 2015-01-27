//
//  MurrayNode.h
//  ASDK Demo
//
//  Created by Kai Schaller on 1/27/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface MurrayNode : ASCellNode

+ (NSArray *)placeholders;

- (instancetype)initWithMurrayOfSize:(CGSize)size;

@end
