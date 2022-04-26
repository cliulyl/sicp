#lang sicp
; 此程序运行有误

(define (procedure-environment p) (cadddr p))

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

; (define (make-frame variables values)
;   (cons variables values))
;;;; revised:
(define (make-frame variables values)
    (display "make-frame: ")
    (display (cons variables values))
    (newline)
    (if (null? variables)
        '()
        (cons (cons (car variables) (car values))
              (make-frame (cdr variables) (cdr values)))))

; (define (frame-variables frame) (car frame))
; (define (frame-values frame) (cdr frame))
;;;; revised:
(define (frame-variables frame)
    (map car frame))
(define (frame-values frame)
    (map cdr frame))

; (define (add-binding-to-frame! var val frame)
;   (set-car! frame (cons var (car frame)))
;   (set-cdr! frame (cons val (cdr frame))))
;;;; revised:
(define (add-binding-to-frame! var val frame)
    (display "add-binding: ")
    (display (cons var val))
    (newline)
    (set-car! frame (cons (cons var val) (car frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

