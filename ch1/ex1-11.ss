#lang sicp
(define (f_iter n)
    (if (< n 3)
        n
        (+ (f_iter (- n 1))
            (* 2 (f_iter (- n 2)))
            (* 3 (f_iter (- n 3))))
    ) 
)

(define (f_recur n)
    (define (f_recur_base a b c count)
        (cond ((< count 2) count)
            ((= count 2) c)
            (else (f_recur_base b
                                c 
                                (+ c
                                    (* 2 b)
                                    (* 3 a)) 
                                (- count 1))))
    )

    (f_recur_base 0 1 2 n)
)