#lang sicp
(define dx 0.00001)

(define (smooth f)
    (lambda (x)
            (/ (+ (f (- x dx)) (f x) (f (+ x dx)))
               3))
)

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

(define (repeated-smooth f n)
    ((repeated smooth n) f)
)