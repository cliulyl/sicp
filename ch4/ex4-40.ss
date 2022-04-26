#lang sicp
(#%require "ambeval.scm")
(#%require (only racket current-inexact-milliseconds))

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5)))
      (require (not (= baker 5)))
      (let ((cooper (amb 1 2 3 4 5)))
           (require (not (= cooper 1)))
           (let ((fletcher (amb 1 2 3 4 5)))
                (require (not (= fletcher 5)))
                (require (not (= fletcher 1)))
                (let ((miller (amb 1 2 3 4 5)))
                     (require (> miller cooper))
                     (let ((smith (amb 1 2 3 4 5)))
                          (require (not (= (abs (- smith fletcher)) 1)))
                          (require (not (= (abs (- fletcher cooper)) 1)))
                          (require (distinct? (list baker cooper fletcher miller smith)))
                          (list (list 'baker baker)
                                (list 'cooper cooper)
                                (list 'fletcher fletcher)
                                (list 'miller miller)
                                (list 'smith smith))))))))

))

(define star-time (current-inexact-milliseconds))
(easy-ambeval 10 '(begin
(multiple-dwelling)
))
(- (current-inexact-milliseconds) star-time)