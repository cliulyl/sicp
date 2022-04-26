#lang sicp
;;; part b
(define (install-deriv-package)
    ;internal procedures
    (define (deriv-sum exp var)
        (define (addend exp) (car exp))
        (define (augend exp) (cadr exp))
        (make-sum (deriv (addend exp) var)
                  (deriv (augend exp) var)))
    (put 'deriv '+ deriv-sum)
    'done
)