#lang racket

(require "stream.scm")
(require "infinite_stream.scm")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
    (lambda (i-stream v0)
            (add-streams (scale-stream i-stream R)
                         (scale-stream (integral i-stream (* v0 C) dt) (/ 1 C)))))

(define RC1 (RC 5 1 0.5))

(define ones (cons-stream 1 ones))
(display-stream-n (RC1 ones 0.1) 20)