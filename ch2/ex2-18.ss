#lang sicp
(define (reverse a)
    (define (recur-base a ret)
        (cond ((null? a) ret)
              (else (recur-base (cdr a) (cons (car a) ret)))))
    (recur-base a nil)
)
