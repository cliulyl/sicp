#lang sicp
;;;;;;; libs
(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

; 累加器
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;过滤器
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
;;;;;;;

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (board-pos col row) (list col row))
(define (same-row pos1 pos2) (= (cadr pos1) (cadr pos2)))
(define (same-diagonal1 pos1 pos2)
    (= (+ (car pos1) (cadr pos1))
       (+ (car pos2) (cadr pos2)))
)
(define (same-diagonal2 pos1 pos2)
    (= (- (car pos1) (cadr pos1))
       (- (car pos2) (cadr pos2)))
)

(define empty-board nil)

(define (adjoin-position new-row k rest-of-queens)
    (cons (board-pos k new-row) rest-of-queens)
)

(define (safe? k positions)
    (define (iter-base k-pos res)
        (if (null? res)
            #t
            (and (let ((com-pos (car res)))
                      (and (not (same-row k-pos com-pos))
                           (not (same-diagonal1 k-pos com-pos))
                           (not (same-diagonal2 k-pos com-pos))))
                (iter-base k-pos (cdr res)))))
    (iter-base (car positions) (cdr positions))
)