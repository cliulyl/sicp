#lang sicp
(#%require "constraints.scm")
(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c- x y)
    (let ((z (make-connector)))
        (adder y z x)
        z))

(define (c* x y)
    (let ((z (make-connector)))
        (multiplier x y z)
        z))

(define (c/ x y)
    (let ((z (make-connector)))
        (multiplier y z x)
        z))

(define (cv x)
    (let ((z (make-connector)))
        (constant x z)
        z))

;test
(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "C" C)
(probe "F" F)

(set-value! C 100 'user)