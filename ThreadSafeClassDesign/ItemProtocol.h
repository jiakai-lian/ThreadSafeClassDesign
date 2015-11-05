//
//  ItemProtocol.h
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemProtocol <NSObject>
@property(nonatomic, copy) NSString *itemId;
@property(nonatomic, copy) NSString *itemName;

+ (instancetype)itemWithItemId:(NSString *)itemId
                      itemName:(NSString *)itemName
               itemDescription:(NSString *)itemDescription;

- (NSString *)description;


@end
