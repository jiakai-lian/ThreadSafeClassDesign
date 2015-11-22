//
//  ItemSyncSelf.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemSyncSelf.h"

@implementation ItemSyncSelf
@synthesize subItems = _subItems;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _subItems = [NSArray array];
    }
    return self;
}

#pragma mark - Public Properties
- (NSArray *)subItems {
    @synchronized (self) {
        return _subItems;
    }
}

//- (void)setsubItems:(NSArray *)subItemsArray {
//    __block NSArray * array = subItemsArray.copy;
//    @synchronized (self) {
//        _subItems = array;
//    }
//}

- (void)addsubItem:(NSString *)string
{
    @synchronized (self) {
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.subItems];
    [array addObject:string];
    self.subItems = array;
    }
}


@end
