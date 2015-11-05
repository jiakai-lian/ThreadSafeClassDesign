//
//  ItemAsyncSetter.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemAsyncSetter.h"

@implementation ItemAsyncSetter


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

- (NSString *)itemId {
    __block NSString * itemIdStr;
    dispatch_sync(self.syncQueue, ^{
        itemIdStr = _itemId;
    });
    return itemIdStr;
}

- (void)setItemId:(NSString *)itemId {
    dispatch_async(self.syncQueue, ^{
        _itemId = itemId;
    });
}


- (NSString *)itemName {
    __block NSString * itemNameStr;
    dispatch_sync(self.syncQueue, ^{
        itemNameStr = _itemName;
    });
    return itemNameStr;
}

- (void)setItemName:(NSString *)itemName {
    dispatch_async(self.syncQueue, ^{
        _itemName = itemName;
    });
}

- (NSString *)itemDescription {
    __block NSString * itemDescriptionStr;
    dispatch_sync(self.syncQueue, ^{
        itemDescriptionStr = _itemDescription;
    });
    return itemDescriptionStr;
}

- (void)setItemDescription:(NSString *)itemDescription {
    dispatch_async(self.syncQueue, ^{
        _itemDescription = itemDescription;
    });
}

#pragma mark - Private Properties
- (dispatch_queue_t)syncQueue {
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    });
    
    return queue;
}

@end
