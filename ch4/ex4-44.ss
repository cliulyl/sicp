#lang sicp
;;未能成功运行
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

(define (append x y)
  (if (null? x)
      y 
      (cons (car x) (append (cdr x) y))))

; (define (map proc items)
;   (if (null? items)
;       null
;       (cons (proc (car items))
;             (map proc (cdr items)))))

(define (an-integer-between low high)
    (require (<= low high))
    (amb low (an-integer-between (+ low 1) high)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (no-attack? new-num old-list count k)
    (define (same-row? pos1 pos2)
        (= (car pos1) (car pos2)))
    (define (same-diag? pos1 pos2)
        (= (abs (- (car pos1) (car pos2))) 
           (abs (- (cdr pos1) (cdr pos2)))))
    (if (null? old-list)
        true
        (let ((old-pos (cons (car old-list) count))
              (new-pos (cons new-num k)))
            (cond ((= count k) true)
                  ((same-row? new-pos old-pos) false)
                  ((same-diag? new-pos old-pos) false)
                  (else (no-attack? new-num (cdr old-list) (+ count 1) k))))))
    
(define (queens board-size)
    (define (queen-cols k)
        (let ((new-pos (an-integer-between 1 board-size)))
            (if (= k 1)
                (list new-pos)
                (let ((old-list (queen-cols (- k 1))))
                     (begin (require (no-attack? new-pos old-list 1 k))
                            (append old-list (list new-pos)))))))
    (queen-cols board-size))

))

(define star-time (current-inexact-milliseconds))
(easy-ambeval 10 '(begin
(queens 8)
))
(- (current-inexact-milliseconds) star-time)