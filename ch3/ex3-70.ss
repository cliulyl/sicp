#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm") 
(require "pairs_stream.scm")
(provide merge merge-weighted weighted-pairs)

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (cons-stream s1car (merge (stream-cdr s1) s2)))
                 ((> s1car s2car)
                  (cons-stream s2car (merge s1 (stream-cdr s2))))
                 (else
                  (cons-stream s1car
                               (merge (stream-cdr s1)
                                      (stream-cdr s2)))))))))

(define (merge-weighted s1 s2 weight)
    ; 对两个流s1和s2进行合并，每个流中的元素是双元素的表(i j)，合并按照weight过程给出的权重(weight i j)对元素进行排序。不删除重复
    ; 这里如果把weight定义为直接作用在pair上的权重函数，使用起来会更简单。就不修改了
    (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (let ((i1 (car s1car))
                 (j1 (cadr s1car))
                 (i2 (car s2car))
                 (j2 (cadr s2car)))
              (cond ((<= (weight i1 j1) (weight i2 j2))
                     (cons-stream s1car (merge-weighted (stream-cdr s1) s2 weight)))
                    (else
                     (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))
                    ))))))

(define (weighted-pairs s t weight)
    (cons-stream 
      (list (stream-car s) (stream-car t))
      (merge-weighted
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
        weight))
)


(module* main #f
    ; part a
    (define (weight1 x y) (+ x y))
    (define integer-pairs
        (weighted-pairs integers integers weight1))
    ; (stream-head->list integer-pairs 30)
    
    ; part b
    (define divisible-235-series
        (merge
          (scale-stream integers 2)
          (merge (scale-stream integers 3)
                 (scale-stream integers 5))))
    (define (weight2 x y)
        (+ (* 2 x) (* 3 y) (* 5 x y)))
    (define divisible-235-pairs
        (weighted-pairs divisible-235-series divisible-235-series weight2))
    (stream-head->list divisible-235-pairs 20)
)