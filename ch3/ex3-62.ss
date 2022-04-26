#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "ex3-59.ss")
(require "ex3-60.ss")
(require "ex3-61.ss")

(define (div-series s1 s2)
    (mul-series s1 (reciprocal-series s2)))

(define tan-series
    (div-series sine-series cosine-series))

(module* main #f
    (stream-head->list tan-series 20)
)