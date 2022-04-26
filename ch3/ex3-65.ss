#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm") 

(define (base n)
    (cons-stream ((if (even? n) - +) (/ 1.0 n))
                 (base (+ n 1))))

(define sum1
    (partial-sums (base 1)))

(define sum2
    (euler-transform sum1))

(define sum3
    (accelerated-sequence euler-transform sum1))