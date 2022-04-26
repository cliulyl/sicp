#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "ex3-59.ss")
(require "ex3-60.ss")
(provide reciprocal-series)

(define (unit-reciprocal-series s)
    (define reciprocal
        (cons-stream 1
                     (stream-map - (mul-series (stream-cdr s)
                                               reciprocal))))
    reciprocal)

(define (reciprocal-series s)
    (if (= (stream-car s) 0)
        (error "The constant of input series cannot be zero" s)
        (let ((coef (/ 1 (stream-car s))))
            (scale-stream (unit-reciprocal-series (scale-stream s coef)) coef))))
        

(module* main #f
  (define a (unit-reciprocal-series cosine-series))
  (stream-head->list (mul-series a cosine-series) 20) ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  
  (define b (unit-reciprocal-series exp-series))
  (stream-head->list (mul-series b exp-series) 20)    ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  
  (define c (reciprocal-series (scale-stream cosine-series 5)))
  (stream-head->list (mul-series c (scale-stream cosine-series 5)) 20) ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  
  (define d (reciprocal-series (scale-stream exp-series 3)))
  (stream-head->list (mul-series d (scale-stream exp-series 3)) 20)    ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
)
