#lang sicp
(define (iterative-improve good-enough? improve)
    (define (iter-base guess)
        (if (good-enough? guess)
            guess
            (iter-base (improve guess)))
    )
    iter-base
)

;使用iterative-improve重写sqrt
(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
    (define (good-enough1? guess)
        (< (abs (- (square guess) x)) 0.001))
    (define (improve1 guess)
        (average guess (/ x guess))
    )
    ((iterative-improve good-enough1? improve1) 1.0)
)
;;;

;使用iterative-improve重写fixed-point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (good-enough2? guess)
        (close-enough? guess (f guess))) 
    (define (improve2 guess)
        (f guess))
    ((iterative-improve good-enough2? improve2) first-guess)
)
;;;