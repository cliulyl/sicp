#lang sicp
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a)
                  (accumulate combiner null-value term (next a) next b)))
)

(define (accumulate-recur combiner null-value term a next b)
    (define (recur-base a result)
        (if (> a b)
            result
            (recur-base (next a) (combiner (term a) result))
            ))
    (recur-base a null-value)
)

(define (sum term a next b)
    (accumulate + 0 term a next b)
)

(define (product term a next b)
    (accumulate * 1 term a next b)
)