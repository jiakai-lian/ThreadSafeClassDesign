//
//  ItemAtomic.h
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemProtocol.h"

@interface ItemAtomic : NSObject<ItemProtocol>

@property(atomic, copy) NSString *itemId;
@property(atomic, copy) NSString *itemName;
@property(atomic, copy) NSString *itemDescription;

- (instancetype)initWithItemId:(NSString *)itemId
                      itemName:(NSString *)itemName
               itemDescription:(NSString *)itemDescription;

+ (instancetype)itemWithItemId:(NSString *)itemId
                      itemName:(NSString *)itemName
               itemDescription:(NSString *)itemDescription;

- (NSString *)description;


@end
