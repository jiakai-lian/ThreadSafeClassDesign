# ThreadSafe Class Design
An experiment  on Objective-C thread safe Model class design.


> **One class is either thread safe or it is not.**

Introduction：
--------------------


Multithreading issue could be very tricky and hard to be fixed.  To prevent random crashes, especially the bad access problem, I did an experiment on different threadsafe implementations and measured corresponding performance metrics.

In this experiment, the numbers of read and write actions are 9 : 1. In other words,  at each test case, there are 90% read actions, and 10% write actions， It is a similar to real configuration which I did purposely. 

Please check these scenario folders for the detail implementations. 


Proposed Approaches：
--------------------

| Class/Queue       | Reader           | Writer  | ThreadSafe| Reason|
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|
| No Protection			| N/A | N/A | N |
| Atomic      			| N/A | N/A | N | Atomic cannot ensure threadsafe. It can reduce the chance of crash, but unable to prevent it from happening.|
| NSLock	| N/A | N/A | Y | Each actions are excuted exclusively due to the NSLock protection.
| @synchornized(self)	| N/A | N/A | Y | Each actions are excuted exclusively due to the syncorized protection.
| SerialQueue      		| Sync | Sync | Y | The queue only excute one action at a time
| SerialQueue      		| Sync | Async | Y |As same as above
| ConcurrentQueue		| Sync | Sync | N |Although each read and write actions are synchronized to the callers, at an any time point, it is possible that multi actions are executed on that queue. |
| ConcurrentQueue		| Sync | Async | N | As same as above
| ConcurrentQueue		| Sync | BarrierAsync | Y | One write action is executed exclusively with other write & read actions. |


Another great explanation from StackOverFlow:
> **async - concurrent**: the code runs on a background thread. Control
> returns immediately to the main thread (and UI). The block can't
> assume that it's the only block running on that queue.
> 
> **async - serial**: the code runs on a background thread. Control returns
> immediately to the main thread. The block can assume that it's the
> only block running on that queue.
> 
> **sync - concurrent**: the code runs on a background thread but the main
> thread waits for it to finish, blocking any updates to the UI. The
> block can't assume that it's the only block running on that queue (I
> could have added another block using async a few seconds previously)
> 
> **sync - serial**: the code runs on a background thread but the main
> thread waits for it to finish, blocking any updates to the UI. The
> block can assume that it's the only block running on that queue.

Performance:
---------------------
The following chart shows average time for 10k actions in each type of implementations. 
![Performance Results](https://raw.githubusercontent.com/jiakai-lian/ThreadSafeClassDesign/master/performance.png)

Recommended Approach:
---------------------

**Concurrent Queue with sync reader and barrier async writer.**

FAQ:
----
1. Why lock for read action
2. How do not use a global queue?
> Because the global queues are a shared resource and it doesn't make
> sense to allow a single component to block them for everybody.


References:

https://www.objc.io/issues/2-concurrency/thread-safe-class-design/

http://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd

https://www.mikeash.com/pyblog/friday-qa-2011-10-14-whats-new-in-gcd.html

Effective Objective-C 2.0 - Item 41

# 中文版本
-------------

>#**一个类要么是多线程安全的，要么它就不是。**

# 前言
-------------

多线程情况下的随机crash是在iOS 编程过程中比较常见的一种问题， 并且这种类型的bug排查和修改都相对比较困难。网络上有挺多讲解多线程概念和基本用法的文章，在此我就不重复讲解了。 不过我发现很少有文章对各种不同实现进行对比和测试。所以就写了这一篇文章。 

本文主要是通过探索如何实现一个线程安全的model类， 从而验证不同的实现方式是否能真正实现线程安全，同时也对这些实现的性能做一个初步的横向比较。

在Objective-C中，多线程相关的概念主要有atomic, NSLock, @synchronize, GCD, NSOperation. 由于NSOperation在底层上是通过GCD来实现的，所以本文将主要讨论前4种概念相关的实现方式。

#代码实现
--------------------------

>详细的实现代码请参考**https://github.com/jiakai-lian/ThreadSafeClassDesign** 。


#实验结果分析
--------------------------
以下是不同实现方式的线程安全的实验结果：

| 类/Queue | 读 |  写 | 线程安全| 原因分析|
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|
| 无保护			| N/A | N/A | N ||
| Atomic 			| N/A | N/A | N | 很多人误解，以为设置成atomic就可以保证线程安全， 其实并非如此。具体原因见文末的补充说明|
| NSLock | N/A | N/A | Y | 互斥锁可以保证锁之间的所有操作都是互斥的。性能基本上和@synchronized相当。|
| @synchornized(self)	| N/A | N/A | Y | 这种方式是最偷懒省事的办法。性能方面相对要差一些|
| SerialQueue | Sync | Sync | Y | 不管是sync 还是async 操作，serial queue可以保证一次只有一个block在执行，所以是线程安全的。
| SerialQueue | Sync | Async | Y | 同上
| ConcurrentQueue | Sync | Sync | N |不管是sync write，还是async write 是无法保证线程安全的。因为在任意时间点，可能有多个write block在queue中运行。 |
| ConcurrentQueue | Sync | Async | N | 同上
| ConcurrentQueue | Sync | BarrierAsync | Y | 改用Barrier Async write 以后，写操作之间是互斥的。同时在写操作完成之前，不会执行之后加入的read操作，所以不会发生在数据在写的过程当中被读取的情况。 |

线程安全实现之间的性能比较

![10k test block的平均执行时间（毫秒）](https://raw.githubusercontent.com/jiakai-lian/ThreadSafeClassDesign/master/performance.png)

#总结
---------------------
总体来说,**并发读互斥写（Concurrent read，Exclusive write）**是一个比较理想的多线程工作模式， 在确保线程安全同时也保留了多线程的性能优势。在Objective-C中，这种模式的具体实现就是**concurrentQueue+sync read+barrier async write**。当然，如果对于少量代码需要线程安全，同时性能方面要求不高的应用场景来说，**@synchronized**也是一种比较便捷的实现方式。

#补充说明
----------------------
- ####为什么atomic 无法保证线程安全
>Atomic 只能保证单步操作的原子性。因此，对于简单的赋值或者读取操作，atomic还是可以保证该操作的完整性。但是，一旦涉及到多步骤操作，还是需要lock等其他的同步机制来确保线程安全。
>
>####实例：
>@peroperty(atomic, strong) NSMutableArray * array;
>
>array = [NSMutableArray array]; //线程安全
>
>[array addObject:dummyObject];//线程不安全，在读取array后，执行addObject 的过程中，array所指向的object 可能已经在其他地方被释放了
>
>而在实际应用中，大部分操作都是多步骤操作，atomic可以在一定程度上减少crash的几率，从而掩盖多线程问题，但是却无法从根本上解决线程安全问题。

- ####为什么说@synchronized（self）的性能差
>@synchronized 所包含的代码片段 一次只允许一个线程执行，同时又会阻塞调用线程， 类似上述表格中Serial queue + dispatch sync 的组合 。一旦这些代码片段同时被多个线程访问，就会对性能造成较大的影响。

- ####测试代码中读操作：写操作数量 9：1 的原因说明
>在实际的项目中，绝大部分情况都是读取数据，只有小部分情况需要写数据。 这样的设置主要是为了模拟实际的使用情况，增加测试结果的可参考性。

如有错漏，欢迎指正。

#参考资料
---------------------------
https://www.objc.io/issues/2-concurrency/thread-safe-class-design/

http://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd

https://www.mikeash.com/pyblog/friday-qa-2011-10-14-whats-new-in-gcd.html

Effective Objective-C 2.0 - Item 41
