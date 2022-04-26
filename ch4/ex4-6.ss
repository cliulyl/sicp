#lang sicp
(define (let? exp)
    (tagged-list? exp 'let))

(define (let->combination exp)
    (cons (make-lambda (let-variables exp) (let-body exp))
          (let-exps exp)))

(define (let-variables exp)
    (map car (cadr exp)))

(define (let-exps exp)
    (map cadr (cadr exp)))

(define (let-body exp)
    (cddr exp))