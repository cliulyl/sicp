#lang sicp
(define (last-pair a)
    (define (iter-base c ret)
        (if (null? ret)
            c
            (iter-base ret (cdr ret))))
    (if (null? a)
        (error "Given list is null!" a)
        (iter-base a (cdr a)))
)