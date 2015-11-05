//
//  ItemSyncSelf.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemSyncSelf.h"

@implementation ItemSyncSelf
@synthesize itemId = _itemId;
@synthesize itemName = _itemName;
@synthesize itemDescription = _itemDescription;

- (instancetype)initWithItemId:(NSString *)itemId
                      itemName:(NSString *)itemName
               itemDescription:(NSString *)itemDescription {
    self = [self init];
    if (self) {
        _itemId = [itemId copy];
        _itemName = [itemName copy];
        _itemDescription = [itemDescription copy];
    }
    
    return self;
}

+ (instancetype)itemWithItemId:(NSString *)itemId
                      itemName:(NSString *)itemName
               itemDescription:(NSString *)itemDescription {
    return [[self alloc] initWithItemId:itemId
                               itemName:itemName
                        itemDescription:itemDescription];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ",
                                    NSStringFromClass([self class])];
    [description appendFormat:@"self.itemDescription=%@",
     self.itemDescription];
    [description appendFormat:@", self.itemId=%@",
     self.itemId];
    [description appendFormat:@", self.itemName=%@",
     self.itemName];
    [description appendString:@">"];
    return description;
}


#pragma mark - Public Properties

//- (NSString *)itemId {
//    __block NSString * itemIdStr;
//    dispatch_sync(self.syncQueue, ^{
//        itemIdStr = _itemId;
//    });
//    return itemIdStr;
//}
//
//- (void)setItemId:(NSString *)itemId {
//    dispatch_sync(self.syncQueue, ^{
//        _itemId = itemId;
//    });
//}

- (NSString *)itemId {
    @synchronized (self) {
        return _itemId;
    }
}

- (void)setItemId:(NSString *)itemId {
    @synchronized (self) {
        _itemId = itemId;
    }
}

- (NSString *)itemName {
    @synchronized (self) {
        return _itemName;
    }
}

- (void)setItemName:(NSString *)itemName {
    @synchronized (self) {
        _itemName = itemName;
    }
}

- (NSString *)itemDescription {
    @synchronized (self) {
        return _itemDescription;
    }
}

- (void)setItemDescription:(NSString *)itemDescription {
    @synchronized (self) {
        _itemDescription = itemDescription;
    }
}

//#pragma mark - Private Properties
//- (dispatch_queue_t)syncQueue {
//    static dispatch_queue_t queue = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
//    });
//
//    return queue;
//}


@end
