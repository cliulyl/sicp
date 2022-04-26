#lang sicp
(define (fringe items)
    (cond ((null? items) nil)
          ((not (pair? items)) (cons items nil))
          (else (append (fringe (car items)) (fringe (cdr items)))))
)