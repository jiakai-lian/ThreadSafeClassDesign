//
//  ItemSyncQueue.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemSyncQueue.h"

@implementation ItemSyncQueue

@synthesize itemCount = _itemCount;

#pragma mark - Public Properties
- (NSUInteger)itemCount {
    __block NSUInteger count;
    dispatch_sync(self.syncQueue, ^{
        count = _itemCount;
    });
    return count;
}

- (void)setItemCount:(NSUInteger)itemCount {
    dispatch_sync(self.syncQueue, ^{
        _itemCount = itemCount;
    });
}

#pragma mark - Private Properties
- (dispatch_queue_t)syncQueue {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.jiakai.ItemSyncQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return queue;
}

@end
