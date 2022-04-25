#lang sicp

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        

(define (square x) (* x x))

(define (complete-fermat-test n)
    (define (try-it n a)
        (= (expmod a n n) a)
    )
    (define (test-iter n count)
        (cond ((= n count) true)
              ((try-it n count) (test-iter n (+ count 1))) 
              (else false)
        )
    )
    (test-iter n 2)
)
(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
    (define (next1-divisor d)
        (+ d 1)
    )
    (define (next2-divisor d)
        (if (= d 2)
            3
            (+ d 2))
    )
    (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next2-divisor test-divisor)))))

(define (prime? n)
    (= (smallest-divisor n) n)
)

(define (search-for-carmichael n count)
    (cond ((= count 0) (display "End"))
          ((and (not (prime? n)) (complete-fermat-test n)) (display n) (newline) (search-for-carmichael (+ n 1) (- count 1)))
          (else (search-for-carmichael (+ n 1) count)) 
    )
)