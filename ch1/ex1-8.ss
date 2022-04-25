#lang sicp
(define (cube_root x)
    (define (cube_root_iter guess)
        (if (good_enough? guess)
            guess
            (cube_root_iter (improve guess))) 
    )
    (define (good_enough? guess)
        (< (abs (/ (- (improve guess) guess) guess)) 0.01)
    )
    (define (improve guess)
        (/ (+ (/ x (* guess guess))
                (* 2 guess))
            3) 
    )
    (cube_root_iter 1.0))

