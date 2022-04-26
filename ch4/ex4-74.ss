#lang sicp

(define (simple-stream-flatmat proc s)
    (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
    (stream-map stream-car
                (stream-filter (lambda (item) (not (stream-null? item))) stream))