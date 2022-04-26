#lang sicp
(define (let*->nested-lets exp)
    (let ((parameters (let-parameters exp)))
         (if (last-parameter? parameters)
             (make-let parameters (let-body exp))
             (make-let (list (car parameters))
                        ;; 注意！！！下面这行作为body，需要是一个序列，需要写为list
                       (list (let*->nested-lets (make-let* (cdr parameters)
                                                     (let*-body exp))))))))

(define (make-let parameters body)
    (cons 'let (cons parameters body)))

(define (let-parameters exp)
    (cadr exp))

(define (make-let* parameters body)
    (cons 'let* (cons parameters body)))

(define (let*-body exp)
    (cddr exp))