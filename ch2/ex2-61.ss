#lang sicp
;;; ordered
(define (adjoin-set x set)
    (if (null? set)
        (list x)
        (let ((s1 (car set)))
            (cond ((< x s1) (cons x set))
                ((= x s1) set)
                (else (cons s1 (adjoin-set x (cdr set))))))))
    
