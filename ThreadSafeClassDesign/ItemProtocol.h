//
//  ItemProtocol.h
//  ThreadSafeClassDesign
//
//  Created by bluecats on 6/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemProtocol <NSObject>


- (NSUInteger)itemCount;

- (void)setItemCount:(NSUInteger)itemCount;
@end
