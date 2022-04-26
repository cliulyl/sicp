#lang racket
(define f
    (let ((init-value 0))
        (lambda (x)
                (begin (set! init-value (if (> x 0) x (- init-value 1)))
                       init-value)))
)

(+ (f 0) (f 1))
(+ (f 1) (f 0))