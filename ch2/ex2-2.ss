#lang sicp
(define (make-segment start-point end-point)
    (cons start-point end-point))

(define (start-segment segment)
    (car segment))

(define (end-segment segment)
    (cdr segment))

(define (make-point x y)
    (cons x y))

(define (x-point p)
    (car p))

(define (y-point p)
    (cdr p))

(define (average a b)
    (/ (+ a b) 2))

(define (midpoint-segment segment)
    (let ((x1 (x-point (start-segment segment)))
          (x2 (x-point (end-segment segment)))
          (y1 (y-point (start-segment segment)))
          (y2 (y-point (end-segment segment))))
        (make-point (average x1 x2) (average y1 y2)) 
    )
)

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

;test
(define p1 (make-point -7 10))
(define p2 (make-point 8 22))
(define seg (make-segment p1 p2))
(print-point (midpoint-segment seg))