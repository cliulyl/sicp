#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "ex3-59.ss")
(provide mul-series)

(define (add-series s1 s2)
    (add-streams s1 s2))

(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (mul-series (stream-cdr s1) s2)
                              (scale-stream (stream-cdr s2) (stream-car s1)))))

(module* main #f
    (define ret-series
        (add-series (mul-series sine-series sine-series)
                    (mul-series cosine-series cosine-series)))

    (stream-head->list ret-series 10)

    (define ones (cons-stream 1 ones))

    (define incre
        (mul-series ones ones))

    (stream-head->list incre 10)
)