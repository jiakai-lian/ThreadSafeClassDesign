//
//  ItemAtomic.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "ItemAtomic.h"

@implementation ItemAtomic


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


@end
