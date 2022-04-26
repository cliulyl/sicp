#lang sicp
(define (insert-list item lst n)
    (if (= n 0)
        (cons item lst)
        (cons (car lst) (insert-list item (cdr lst) (- n 1)))))
        
(define (shuffle lst)
    (if (<= (length lst) 1)
        lst
        (let ((n (random (length lst))))
            (insert-list (car lst) (shuffle (cdr lst)) n))))

(define (ramb-choices exp) (shuffle (cdr exp)))

(define (ramb? exp) (tagged-list? exp 'ramb))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices))))))
      (try-next cprocs))))

