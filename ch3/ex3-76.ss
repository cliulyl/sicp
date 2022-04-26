#lang racket

(require "stream.scm")
(require "infinite_stream.scm")

(define (smooth s)
    (scale-stream
      (add-streams s (stream-cdr s))
      (/ 1 2)))

(define (define make-smoothed-zero-crossings input-stream smooth)
    (let ((processed (smooth input-stream)))
         (make-zero-crossings processed 0)))

;: (define zero-crossings (make-zero-crossings sense-data 0))