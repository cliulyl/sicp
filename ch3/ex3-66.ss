#lang racket
(define (rank-in-pairs n1 n2)
    (cond ((> n1 n2) (error "must be n1 <= n2" (n1 n2)))
          ((= n1 0) (if (= n2 0)
                        1
                        (* n2 2)))
          (else (+ (* (rank-in-pairs (- n1 1) (- n2 1)) 2) 1))))

(module* main #f
    (rank-in-pairs 0 99)
    (rank-in-pairs 99 99)
)