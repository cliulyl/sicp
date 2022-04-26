#lang sicp

(define (cons2 x y)
    (let ((a 2)
          (b 3))
        (* (expt a x) (expt b y))      
    )
)

;使用迭代法寻找整数n对于因子factor能分解几次
(define (factor-time n factor)
    (define (factor-time-base n factor c)
        (if (= (remainder n factor) 0)
            (factor-time-base (/ n factor) factor (+ c 1))
            c
        )
    )
    (factor-time-base n factor 0)
)

(define (car2 prod)
    (let ((a 2))
        (factor-time prod a)) 
)

(define (cdr2 prod)
    (let ((b 3))
        (factor-time prod b))
)

(define (expt b n)
    (define (recur_expt_base a b n)
        (cond ((= n 0) a)
              ((even? n) (recur_expt_base a (square b) (/ n 2)))
              (else (recur_expt_base (* a b) b (- n 1)))
        ) 
    )
    (recur_expt_base 1 b n)
)
(define (square x) (* x x))
(define (even? n)
    (= (remainder n 2) 0)
)