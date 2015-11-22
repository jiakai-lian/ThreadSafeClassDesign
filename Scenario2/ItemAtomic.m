//
//  ItemAtomic.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemAtomic.h"

@implementation ItemAtomic

- (instancetype)init
{
    self = [super init];
    if (self) {
        _subItems = [NSArray array];
    }
    return self;
}

- (void)addsubItem:(NSString *)string
{
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.subItems];
    [array addObject:string];
    self.subItems = array;
}

@end
