#lang sicp

;;;; add next line to eval
; ((unbound? exp) (eval-unbound exp env))

(define (unbound? exp) (tagged-list? exp 'make-unbound!))

(define (eval-unbound exp env) 
    (unbound! (unbound-var exp) env)
    'ok)

(define (unbound-var exp) (cadr exp))

(define (scan-base vars vals var null-op find-op)
    (cond ((null? vars) (null-op))
          ((eq? var (car vars)) (find-op vars vals))
          (else (scan-base (cdr vars) (cdr vals) var null-op find-op))))

(define (remove-car l)
  (set-car! l (cadr l))
  (set-cdr! l (cddr l)))

(define (unbound! var env)
    (let ((frame (first-frame env)))
        (scan-base (frame-variables frame)
                   (frame-values frame)
                   var
                   (lambda () (display "WARNING: no bind in the existing envrironment!"))
                   (lambda (vars vals)
                           (remove-car vars)
                           (remove-car vals)))))