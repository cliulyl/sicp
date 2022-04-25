#lang sicp
(define (bigger_sum x y z)
   (cond ((and (<= x y) (<= x z)) (+ y z))
       ((and (<= y x) (<= y z)) (+ x z))
       (else (+ x y))
       ) )

(bigger_sum 2 3 5)
(bigger_sum 6 3 1)
(bigger_sum 1 4 -2)