//
//  ItemLock.m
//  ThreadSafeClassDesign
//
//  Created by jiakai lian on 7/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemLock.h"

@interface ItemLock()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation ItemLock

@synthesize itemCount = _itemCount;



#pragma mark - Public Properties
- (NSUInteger)itemCount {
    
    [self.lock lock];
    NSUInteger count = _itemCount;
    [self.lock unlock];
    return count;
}

- (void)setItemCount:(NSUInteger)itemCount {
    [self.lock lock];
        _itemCount = itemCount;
    [self.lock unlock];
}

#pragma mark - private Properties
- (NSLock *)lock {
    static NSLock  *internalLock = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internalLock = [[NSLock alloc] init];
    });
    
    return _lock = internalLock;
}




@end
