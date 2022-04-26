#lang racket
(define (make-accumulator value)
    (lambda (x)
            (begin (set! value (+ value x))
                   value))
)