//
//  ItemSyncQueue.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemSyncQueue.h"

@implementation ItemSyncQueue

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
    __block NSArray * array;
    dispatch_sync(self.syncQueue, ^{
        array = _subItems;
    });
    return array;
}

//- (void)setsubItems:(NSArray *)subItemsArray {
//    __block NSArray * array = subItemsArray.copy;
//    dispatch_sync(self.syncQueue, ^{
//        _subItems = array;
//    });
//}

- (void)addsubItem:(NSString *)string
{
//    __weak typeof(self) weakself = self;
    dispatch_sync(self.syncQueue, ^{
        NSMutableArray * array = [NSMutableArray arrayWithArray:_subItems];
        [array addObject:string];
        _subItems = array.copy;
    });
}

#pragma mark - Private Properties
- (dispatch_queue_t)syncQueue {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.jiakai.ItemSyncQueue", DISPATCH_QUEUE_SERIAL);
    });
    
    return queue;
}

@end
