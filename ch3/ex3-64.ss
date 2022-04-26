#lang racket
(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm") ; for sqrt-stream

(define (stream-limit s tol)
    (let ((after (stream-car (stream-cdr s))))
        (if (< (abs (- (stream-car s) after)) tol)
            after
            (stream-limit (stream-cdr s) tol))))

(define (sqrt x tolerance)
    (stream-limit (sqrt-stream x) tolerance))