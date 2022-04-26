#lang sicp
; (define (make-mobile left right)
;   (list left right))

; (define (make-branch length structure)
;   (list length structure))

; part a
; (define (left-branch mobile) (car mobile))

; (define (right-branch mobile) (car (cdr mobile)))

; (define (branch-length branch) (car branch))

; (define (branch-structure branch) (car (cdr branch)))

; part b
(define (total-weight mobile)
    (if (not (pair? mobile))
        mobile
        (+ (total-weight (branch-structure (left-branch mobile)))
           (total-weight (branch-structure (right-branch mobile)))))
)

; part c
(define (balance? mobile)
    (define (torque branch)
        (* (branch-length branch) (total-weight (branch-structure branch))))
    (if (not (pair? mobile))
        #t
        (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
             (balance? (branch-structure (left-branch mobile)))
             (balance? (branch-structure (right-branch mobile)))))
)

; part d
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile) (car mobile))

(define (right-branch mobile) (cdr mobile))

(define (branch-length branch) (car branch))

(define (branch-structure branch) (cdr branch))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define x (make-branch 1 2))
(define b (make-mobile x (make-branch 1 (make-mobile x x))))
(define c (make-mobile (make-branch 1 (make-mobile x x)) (make-branch 1 (make-mobile x x))))

(total-weight b)
(total-weight c)
(balance? b)
(balance? c)