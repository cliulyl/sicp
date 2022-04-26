#lang racket
(require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

;;;;;; libs

;;;;;;

(define (make-segment s e) (cons s e))

(define (start-segment seg) (car seg))

(define (end-segment seg) (cdr seg))