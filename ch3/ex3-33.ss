#lang sicp
(#%require "constraints.scm")

; (define (averager a b c)
;     (define (process-new-value)
;         (cond ((and (has-value? a) (has-value? b))
;                (set-value! c
;                     (/ (+ (get-value a) (get-value b)) 2)
;                     me))
;               ((and (has-value? a) (has-value? c))
;                (set-value! b
;                     (- (* (get-value c) 2) (get-value a))
;                     me))
;               ((and (has-value? b) (has-value? c))
;                (set-value! a
;                     (- (* (get-value c) 2) (get-value b))
;                     me))))
;     (define (process-forget-value)
;         (forget-value! c me)
;         (forget-value! a me)
;         (forget-value! b me)
;         (process-new-value))
;   (define (me request)
;         (cond ((eq? request 'I-have-a-value)  
;            (process-new-value))
;           ((eq? request 'I-lost-my-value) 
;            (process-forget-value))
;           (else 
;             (error "Unknown request -- ADDER" request))))
;   (connect a me)
;   (connect b me)
;   (connect c me)
;   me
; )

(define (averager a b c)
    (let ((sum (make-connector))
          (coe (make-connector)))
        (adder a b sum)
        (constant (/ 1 2) coe)
        (multiplier sum coe c)
        'ok)
)

;test
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)
(probe "a" a)
(probe "b" b)
(probe "c" c)

(set-value! a 20 'user)
(set-value! b 30 'user)

(forget-value! a 'user)
(set-value! a 100 'user)