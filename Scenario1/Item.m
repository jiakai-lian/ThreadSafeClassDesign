//
//  Item.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 5/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "Item.h"

@implementation Item

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
