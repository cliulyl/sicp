#lang sicp
;使用递归定义product
(define (product term a next b)
    (if (> a b)
        1
        (* (term a)
           (product term (next a) next b)))
)

;使用迭代定义product
(define (product-recur term a next b)
    (define (recur-base a result)
        (if (> a b)
            result
            (recur-base (next a) (* result (term a)))))
    (recur-base a 1)
)

(define (identity x) x)

(define (inc n) (+ n 1))

;通过product定义阶乘
(define (factorial n)
    (product identity 1 inc n)
)

;通过product求pi的近似解
(define (approx-pi n)
    (define (term a)
        (/ (* (- a 1) (+ a 1)) (* a a)))
    (define (next a)
        (+ a 2))
    (* 4.0 (product-recur term 3 next (+ 3 (* 2 n))))
)