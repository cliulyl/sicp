#lang sicp
;; Fixed points
(define tolerance 0.00001)

(define (show-guess n guess)
    (display n)
    (display "# ")
    (display guess)
    (newline)
)

(define (fixed-point-show f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess n)
        (show-guess n guess)
        (let ((next (f guess)))
        (if (close-enough? guess next)
            next
            (try next (+ n 1)))))
    (try first-guess 1))

; (fixed-point-show (lambda (x) (/ (log 1000) (log x))) 2.0)

(fixed-point-show (lambda (x) 
                          (/ (+ x (/ (log 1000) (log x))) 2)) 
                  2.0)