#lang sicp
(#%require "ambeval.scm")
(#%require (only racket current-inexact-milliseconds))

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))


(define (five-girls)
    (let ((bette (amb 1 2 3 4 5))
          (asel (amb 1 2 3 4 5))
          (john (amb 1 2 3 4 5))
          (mary (amb 1 2 3 4 5)))
         ()))

))

(define star-time (current-inexact-milliseconds))
(easy-ambeval 10 '(begin
(multiple-dwelling)
))
(- (current-inexact-milliseconds) star-time)