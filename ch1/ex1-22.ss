#lang sicp

(define (timed-prime-test n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (if (prime? n) 
        (report-prime n (- (runtime) start-time))
    )
)

(define (report-prime n elapsed-time)
    (display n)
    (display " *** ")
    (display elapsed-time)
    (newline)
)

(define (square x) (* x x))

; 判断prime
(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n)
    (= (smallest-divisor n) n)
)
;;;;;;

(define (search-by-range min max)
   (define (search-recur n max)
        (cond ((even? n) (search-recur (+ n 1) max))
              ((> n max) (display "end"))
              (else (timed-prime-test n) (search-recur (+ n 2) max)))
   )
   (search-recur min max) 
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

