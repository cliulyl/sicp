#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm") 
(require "pairs_stream.scm")

(define (triples S T U)
    (cons-stream (list (stream-car S) (stream-car T) (stream-car U))
                 (interleave (stream-map (lambda (x) (cons (stream-car S) x))
                                         (stream-cdr (pairs T U)))
                             (triples (stream-cdr S) (stream-cdr T) (stream-cdr U))))
)

(define triple-integers (triples integers integers integers))

(define (square x) (* x x))

(define (equal-sum? tri)
    (= (+ (square (car tri))
          (square (cadr tri)))
       (square (caddr tri))))

(define pythagoras-triples
    (stream-filter equal-sum? triple-integers))

(module* main #f
    (stream-head->list pythagoras-triples 5)
)