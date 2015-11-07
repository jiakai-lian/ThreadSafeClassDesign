//
//  ItemSyncSelf.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemSyncSelf.h"

@implementation ItemSyncSelf
@synthesize itemCount = _itemCount;

#pragma mark - Public Properties
- (NSUInteger)itemCount {
    @synchronized (self) {
        return _itemCount;
    }
}

- (void)setitemCount:(NSUInteger)itemCount {
    @synchronized (self) {
        _itemCount = itemCount;
    }
}

@end
