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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (report-prime n elapsed-time)
    (display n)
    (display " *** ")
    (display elapsed-time)
    (newline)
)

(define (start-prime-test-iter n start-time count)
    (cond ((= count 0) (display "End"))
          ((even? n) (start-prime-test-iter (+ n 1) (runtime) count))
          ((not (fast-prime? n 10)) (start-prime-test-iter (+ n 2) (runtime) count))
          (else (report-prime n (- (runtime) start-time)) (start-prime-test-iter (+ n 2) (runtime) (- count 1))) 
    )
)

(define (search-by-count min count)
    (start-prime-test-iter min (runtime) count)
)