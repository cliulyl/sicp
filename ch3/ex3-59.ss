#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(provide cosine-series sine-series exp-series)

; part a
(define (integrate-series s)  
    ;计算幂级数的积分。输入s是从常数项开始的幂级数；返回不含常数项的积分级数
    (stream-map / s integers))

; part b
(define exp-series
    (cons-stream 1 
                 (integrate-series exp-series)))

(define cosine-series
    (cons-stream 1
                 (stream-map - (integrate-series sine-series))))

(define sine-series
    (cons-stream 0
                 (integrate-series cosine-series)))