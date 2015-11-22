//
//  ItemLock.h
//  ThreadSafeClassDesign
//
//  Created by jiakai lian on 7/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemProtocol.h"

@interface ItemLock : NSObject <ItemProtocol>

@property(nonatomic, copy) NSArray *subItems;

@end
