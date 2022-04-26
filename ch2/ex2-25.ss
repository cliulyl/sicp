#lang sicp
; (define a (list 1 3 (list 5 7) 9))
; (define b (list (list 7 nil) nil))
; (define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(define a '(1 3 (5 7) 9))
(define b '((7)))
(define c '(1 (2 (3 (4 (5 (6 7)))))))

(car (cdr (car (cdr (cdr a)))))
(car (car b))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c))))))))))))