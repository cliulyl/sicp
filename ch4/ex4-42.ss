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

(define (five-girls)
    (define (one-true p q)
        (if p
            (not q)
            q))
    (let ((bette (amb 1 2 3 4 5))
          (asel (amb 1 2 3 4 5))
          (john (amb 1 2 3 4 5))
          (kadi (amb 1 2 3 4 5))
          (mary (amb 1 2 3 4 5)))
         (require (one-true (= kadi 2) (= bette 3)))
         (require (one-true (= asel 1) (= john 2)))
         (require (one-true (= john 3) (= asel 5)))
         (require (one-true (= kadi 2) (= mary 4)))
         (require (one-true (= mary 4) (= bette 1)))
         (require (distinct? (list bette asel john kadi mary)))
         (list (list 'bette bette)
               (list 'asel asel)
               (list 'john john)
               (list 'kadi kadi)
               (list 'mary mary))))
))

(define star-time (current-inexact-milliseconds))
(easy-ambeval 10 '(begin
(five-girls)
))
(- (current-inexact-milliseconds) star-time)