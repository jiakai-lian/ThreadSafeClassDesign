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

@property(atomic, assign) NSUInteger itemCount;


@end
