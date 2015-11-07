//
//  ItemSyncSelf.h
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemProtocol.h"

@interface ItemSyncSelf : NSObject<ItemProtocol>

@property(nonatomic, assign) NSUInteger itemCount;

@end
