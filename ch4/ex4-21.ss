#lang sicp
;part a
((lambda (n)
    ((lambda (fib)
        (fib fib n))
     (lambda (ft k)
        (cond ((= k 1) 1)
              ((= k 0) 0)
              (else (+ (ft ft (- k 1))
                       (ft ft (- k 2))))))))
 5)

;part b
(define (f x)
    ((lambda (even? odd?)
        (even? even? odd? x))
     (lambda (ev? od? n)
        (if (= n 0) true (od? ev? od? (- n 1))))
     (lambda (ev? od? n)
        (if (= n 0) false (ev? ev? od? (- n 1))))))
(f 11)
(f 6)