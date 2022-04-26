#lang sicp
(define (for-each proc items)
    (cond ((not (null? items)) 
           (proc (car items))
           (for-each proc (cdr items))))
)

(for-each (lambda (x) (newline) (display x)) (list 123 456 789))