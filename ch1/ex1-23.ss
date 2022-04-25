#lang sicp

(define (report-prime n elapsed-time)
    (display n)
    (display " *** ")
    (display elapsed-time)
    (newline)
)

(define (square x) (* x x))

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

(define (search-by-count min count)
    (start-prime-test-iter min (runtime) count)
)

(define (start-prime-test-iter n start-time count)
    (cond ((= count 0) (display "End"))
          ((even? n) (start-prime-test-iter (+ n 1) (runtime) count))
          ((not (prime? n)) (start-prime-test-iter (+ n 2) (runtime) count))
          (else (report-prime n (- (runtime) start-time)) (start-prime-test-iter (+ n 2) (runtime) (- count 1))) 
    )
)

