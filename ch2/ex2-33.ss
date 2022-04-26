#lang sicp
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;: (filter odd? (list 1 2 3 4 5))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map2 p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) nil sequence)
)

(define (append2 seg1 seg2)
    (accumulate cons seg2 seg1)
)

(define (length2 sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence)
)