#lang sicp
(define (parity-judge x y) (= (remainder x 2) (remainder y 2)))

(define (same-parity x . args)
    (define (recur-base x result ll)
        (cond ((null? ll) result)
              ((parity-judge x (car ll)) (recur-base x (append result (cons (car ll) nil)) (cdr ll)))
              (else (recur-base x result (cdr ll)))))
    (recur-base x (cons x nil) args)
)

;reading-sicp-master中的一个很妙的解答，采用递归
; (define (filter proc items)
;   (if (null? items)
;       null
;       (if (proc (car items))
;           (cons (car items) (filter proc (cdr items)))
;           (filter proc (cdr items)))))

; (define (same-parity a . w)
;   (cons a 
;         (filter (lambda (x) (even? (+ a x)))
;                 w)))
;;;