#lang racket

(define (eval exp env)
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
          ((and (pair? exp) (get 'eval (car exp)))
           ((get 'eval (car exp)) exp env))
          ((application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          (else
           (error "Unknown expression type -- EVAL" exp))))

(define (install-eval-package)
    (put 'eval 'quote (lambda (exp env) (text-of-quotation exp)))
    (put 'eval 'set! eval-assignment)
    (put 'eval 'define eval-definition)
    (put 'eval 'if eval-if)
    (put 'eval 'lambda (lambda (exp env)
                               (make-procedure (lambda-parameters exp)
                                               (lambda-body exp)
                                               env)))
    (put 'eval 'begin (lambda (exp env)
                              (eval-sequence (begin-actions exp) env)))
    (put 'eval 'cond (lambda (exp env)
                             (eval (cond->if exp) env)))
    (put 'eval 'and (lambda (exp env) (eval-and (and-items exp) env)))
    (put 'eval 'or  (lambda (exp env) (eval-or  (or-items exp) env)))
    'done)

; part a：将and和or作为新的特殊形式
(define (and-items exp) (cdr exp))

(define (first-and-item items) (car items))

(define (rest-and-items items) (cdr items))

(define (eval-and items env)
    (cond ((null? items) 'true)
          ((last-item? items) (eval (first-and-item items) env))  ;这一种情况是需要的，因为在计算到最后一个表达式时，and会返回最后一个表达式的值（例如数值2），而不总是#t
          ((false? (eval (first-and-item items) env)) 'false)
          (else (eval-and (rest-and-items items) env))))

(define (or-items exp) (cdr exp))

(define (first-or-item items) (car items))

(define (rest-or-items items) (cdr items))

(define (eval-or items env)
    (cond ((null? items) 'false)
          ((true? (eval (first-or-items items) env)) 'true)
          (else (eval-or (rest-or-items items) env))))

(define (last-items? items)
    (null? (cdr items)))

; part b: 将and和or实现为派生表达式
(define (and->if exp) (expand-and (and-items exp)))

(define (expand-and items)
    (cond ((null? items) 'true)
          ((last-item? items) (first-and-item items))
          (make-if (first-and-item items)
                   (expand-and (rest-and-items items))
                   'false))

