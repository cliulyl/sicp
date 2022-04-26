#lang sicp
(redefine (eval exp env)      
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (eval-quoted exp env))  ;; changed
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((let? exp) (eval (let->combination exp) env))
        ((application? exp)             ; clause from book
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
         (error "Unknown expression type -- EVAL" exp))))

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (eval-quoted exp env)
    (let ((body (cadr exp)))
        (if (pair? body)
            (eval (quotation-transform body) env)
            body)))

; (define (text-of-quotation exp) (cadr exp))
(define (quotation-transform body) 
    (if (null? (cdr body))
        (list 'cons
              (list 'quote (car body)) 
              ''())
        (list 'cons 
              (list 'quote (car body)) 
              (quotation-transform (cdr body)))))

