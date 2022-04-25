#lang sicp

(define (sum term a next b)
    (if (> a b)
       0
       (+ (term a)
          (sum term (next a) next b)))
)

(define (cube a) (* a a a))

(define (inc a) (+ a 1))

(define (sum-cubes a b)
    (sum cube a inc b)
)

(define (simpson-integral f a b n)
    (define h (/ (- b a) n))
    (define (F a)
        (+ (f a)
           (* 4 (f (+ a h)))
           (f (+ a (* h 2))))
    )
    (define (next a)
        (+ a (* 2 h))    
    )
    (/ (* h (sum F a next (- b (* 2 h)))) 3.0)
)