//
//  ItemLock.m
//  ThreadSafeClassDesign
//
//  Created by jiakai lian on 7/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemLock.h"

@interface ItemLock()

@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation ItemLock

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
    
    [self.lock lock];
    NSArray * array = _subItems;
    [self.lock unlock];
    return array;
}

- (void)addsubItem:(NSString *)string
{
    [self.lock lock];
    NSMutableArray * array = [NSMutableArray arrayWithArray:self.subItems];
    [array addObject:string];
    self.subItems = array;
    [self.lock unlock];
}

//- (void)setsubItems:(NSArray *)subItemsArray {
//    [self.lock lock];
//    _subItems = subItemsArray.copy;
//    [self.lock unlock];
//}

#pragma mark - private Properties
- (NSRecursiveLock *)lock {
    static NSRecursiveLock  *internalLock = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internalLock = [[NSRecursiveLock alloc] init];
    });
    
    return _lock = internalLock;
}




@end
