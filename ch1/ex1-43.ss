#lang sicp
(define (compose f g)
    (lambda (x) (f (g x)))
)

(define (identity x) x)

(define (repeated f n)
    (define (recur-base i ret)
        (if (>= i n)
            ret
            (recur-base (+ 1 i) (compose f ret))))
    (recur-base 0 identity)
)

(define (square x) (* x x))

((repeated square 2) 5)