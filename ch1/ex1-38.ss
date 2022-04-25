#lang sicp
(define (cont-frac n d k)
    (define (iter-base count)
        (if (= k count) 
            (/ (n count) (d count))
            (/ (n count) (+ (d count) (iter-base (+ count 1))))))
    (iter-base 1)
)

(define (d i)
    (if (= (remainder i 3) 2)
        (* (+ i 1) (/ 2 3))
        1
    )
)

(define (approx-e k)
    (+ 2
       (cont-frac (lambda (i) 1.0)
                  d
                  k))
)