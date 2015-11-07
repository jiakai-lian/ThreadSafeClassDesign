# ThreadSafeClassDesign
A personal investigation on thread safe class design (Objective C &amp; Swift2.0)

- No protection
- Atomic Property
- @synchronized
- dispatch_sync  getter & setter
- dispatch_sync getter, dispatch_aync setter
- dispatch_sync getter, dispatch_barrier_async setter
- dispatch_sync getter, muatibilty setter

Why lock for read action

no protection 2/10000

References:

https://www.objc.io/issues/2-concurrency/thread-safe-class-design/

Effective ObjectiveC 2.0 - Item 41
