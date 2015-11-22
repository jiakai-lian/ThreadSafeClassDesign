//
//  main.m
//  ThreadSafeClassDesign
//
//  Created by bluecats on 5/11/2015.
//  Copyright © 2015 jiakai. All rights reserved.
//

#import "Item.h"
#import "ItemAsyncSetter.h"
#import "ItemAtomic.h"
#import "ItemBarrierAsyncSetter.h"
#import "ItemSyncQueue.h"
#import "ItemSyncSelf.h"
#import "ItemLock.h"

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"%@ Time: %f subItemsCount: %ld", NSStringFromClass(item.class), -[startTime timeIntervalSinceNow], (unsigned long)[item subItems].count)

static const NSUInteger DISPATCH_QUEUE_COUNT = 10000;
static const NSUInteger ITERATION_COUNT = 100;

void testScenario(id <ItemProtocol> item) {
    @autoreleasepool {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        TICK;
        
        dispatch_apply(DISPATCH_QUEUE_COUNT, queue, ^(size_t i) {
            if(!(i%10))
            {
                [item addsubItem:@"subItems"];
            }
            else
            {
                NSUInteger n = [item subItems].count;
                n++;
//                 NSLog(@"count = %ld", n);
            }
        });

        TOCK;
    }
}

int main(int argc, const char *argv[]) {
    
    for(NSUInteger i=0; i<ITERATION_COUNT; i++)
    {
//        testScenario([[Item alloc] init]);
        testScenario([[ItemAtomic alloc] init]);
        testScenario([[ItemLock alloc] init]);
        testScenario([[ItemSyncSelf alloc] init]);
        testScenario([[ItemSyncQueue alloc] init]);
        testScenario([[ItemAsyncSetter alloc] init]);
        testScenario([[ItemBarrierAsyncSetter alloc] init]);
    }

    return 0;
}


