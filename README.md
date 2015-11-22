# ThreadSafeClassDesign

> **One class is either thread safe or it is not.**

Introduction：
--------------------


Multithreading issue could be very tricky and hard to be fixed.  To prevent random crashes, especially the bad access problem, I did an experiment on different threadsafe implementations and measured corresponding performance metrics.

In this experiment, the numbers of read and write actions are 9 : 1. In other words,  at each test cases, there are 90% read actions, and 10% write actions， It is a similar to real configuration which I did purposely. 


Proposed Approaches：
--------------------

| Class/Queue       | Reader           | Writer  | ThreadSafe| Reason|
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|
| No Protection			| N/A | N/A | N |
| Atomic      			| N/A | N/A | N | Atomic cannot ensure threadsafe. It can reduce the crashing chances, but unable to prevent it from happening.|
| @sychornized(self)	| N/A | N/A | Y | Each actions are excuted exclusively due to the syncorized protection.
| SerialQueue      		| Sync | Sync | Y | The queue only excute one action at a time
| SerialQueue      		| Sync | Async | Y |As same as above
| ConcurrentQueue		| Sync | Sync | N |Although each read and write actions are synchronized to the callers, at an arbitrary time point, it is possible that multi actions are executed on that queue. |
| ConcurrentQueue		| Sync | Async | N | As same as above
| ConcurrentQueue		| Sync | BarrierAsync | Y | All the write actions are executed exclusively with each other and read actions. |


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
![Performance Results](https://raw.githubusercontent.com/jiakai-lian/ThreadSafeClassDesign/master/performance.png)

Recommended Approach:
---------------------

**Concurrent Queue with sync reader and barrier async writer.**

FAQ:
----
1. Why lock for read action
2. How do not use global queue？
> Because the global queues are a shared resource and it doesn't make
> sense to allow a single component to block them for everybody.


References:

https://www.objc.io/issues/2-concurrency/thread-safe-class-design/
http://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd
https://www.mikeash.com/pyblog/friday-qa-2011-10-14-whats-new-in-gcd.html
Effective ObjectiveC 2.0 - Item 41
