#lang sicp 

(define (my-equal? a b)
    (cond ((and (symbol? a) (symbol? b)) (eq? a b))
          ((and (number? a) (number? b)) (= a b))
          ((and (null? a) (null? b)) true)
          ((and (pair? a) (pair? b)) (and (my-equal? (car a) (car b)) (my-equal? (cdr a) (cdr b))))
          (else false))
)