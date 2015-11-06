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

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"%@ Time: %f", NSStringFromClass(item.class), -[startTime timeIntervalSinceNow])

static const NSUInteger ITERATION_COUNT = 100000;
//static const NSUInteger SLEEP_INTERVAL = 1;

void testScenario(id <ItemProtocol> item) {
    @autoreleasepool {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        TICK;

        dispatch_apply(ITERATION_COUNT, queue, ^(size_t i) {
            if (i % 5) {
                //reader
//                sleep(SLEEP_INTERVAL);
                [item description];
            }
            else {
                //writer
                item.itemId = nil;
//                sleep(SLEEP_INTERVAL);
                item.itemId = [NSString stringWithFormat:@"%zu",
                                                         i];
            }
        });

        TOCK;
    }
}

int main(int argc, const char *argv[]) {
    testScenario([Item itemWithItemId:@"1"
                             itemName:@"item1"
                      itemDescription:@"item1"]);
    testScenario([ItemAtomic itemWithItemId:@"1"
                                   itemName:@"item1"
                            itemDescription:@"item1"]);
    testScenario([ItemSyncSelf itemWithItemId:@"1"
                                     itemName:@"item1"
                              itemDescription:@"item1"]);
    testScenario([ItemSyncQueue itemWithItemId:@"1"
                                      itemName:@"item1"
                               itemDescription:@"item1"]);
    testScenario([ItemAsyncSetter itemWithItemId:@"1"
                                        itemName:@"item1"
                                 itemDescription:@"item1"]);
    testScenario([ItemBarrierAsyncSetter itemWithItemId:@"1"
                                               itemName:@"item1"
                                        itemDescription:@"item1"]);

    return 0;
}


