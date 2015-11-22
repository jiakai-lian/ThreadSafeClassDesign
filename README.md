# ThreadSafeClassDesign
A personal investigation on thread safe class design (Objective C &amp; Swift2.0)


- No protection
- Atomic Property
- @synchronized
- dispatch_sync  getter & setter
- dispatch_sync getter, dispatch_aync setter
- dispatch_sync getter, dispatch_barrier_async setter
- dispatch_sync getter, muatibilty setter

> **async - concurrent**: the code runs on a background thread. Control
> returns immediately to the main thread (and UI). The block can't
> assume that it's the only block running on that queue
> 
> **async - serial**: the code runs on a background thread. Control returns
> immediately to the main thread. The block can assume that it's the
> only block running on that queue
> 
> **sync - concurrent**: the code runs on a background thread but the main
> thread waits for it to finish, blocking any updates to the UI. The
> block can't assume that it's the only block running on that queue (I
> could have added another block using async a few seconds previously)
> 
> **sync - serial**: the code runs on a background thread but the main
> thread waits for it to finish, blocking any updates to the UI. The
> block can assume that it's the only block running on that queue


Why lock for read action

no protection 2/10000

References:

https://www.objc.io/issues/2-concurrency/thread-safe-class-design/
http://stackoverflow.com/questions/19179358/concurrent-vs-serial-queues-in-gcd
Effective ObjectiveC 2.0 - Item 41
