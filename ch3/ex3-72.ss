#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm") 
(require "pairs_stream.scm")
(require "ex3-70.ss")

(define (square x) (* x x))
(define (square-sum x y) (+ (square x) (square y)))
(define (square-sum-of-pair pair)
    (square-sum (car pair) (cadr pair)))

(define all-order-pairs
    (weighted-pairs integers integers square-sum))

(define (result-filter s)
    ;找出所有能够以三种不同方式表示为两个平方数之和的数
    ;这里没有考虑有可能会有超过三种不同方式表示的情况
    (let ((s0 (stream-car s))
          (s1 (stream-car (stream-cdr s)))
          (s2 (stream-car (stream-cdr (stream-cdr s)))))
         (if (= (square-sum-of-pair s0) (square-sum-of-pair s1) (square-sum-of-pair s2))
             (cons-stream (list s0 s1 s2 (square-sum-of-pair s0))
                          (result-filter (stream-cdr s)))
             (result-filter (stream-cdr s)))))

(module* main #f
    (display-stream-n (result-filter all-order-pairs) 10)
)