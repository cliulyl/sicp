#lang racket
(require "stream.scm")
(require "infinite_stream.scm")

(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define factorials
    (cons-stream 1
                 (mul-streams factorials (stream-cdr integers))))