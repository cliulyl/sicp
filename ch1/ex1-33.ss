
#lang sicp
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a)
                  (accumulate combiner null-value term (next a) next b)))
)

; (define (accumulate-recur combiner null-value term a next b)
;     (define (recur-base a result)
;         (if (> a b)
;             result
;             (recur-base (next a) (combiner (term a) result))
;             ))
;     (recur-base a null-value)
; )

;定义一个带过滤器的累积过程
(define (filtered-accumulate combiner null-value filter term a next b)

    (cond ((> a b) null-value)
          ((filter a) (combiner (term a) (filtered-accumulate combiner null-value filter term (next a) next b))) 
          (else (filtered-accumulate combiner null-value filter term (next a) next b))
    )
)

(define (square x) (* x x))

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

(define (inc n) (+ n 1))

(define (identity a) a)

;求a到b之间所有的素数之和
(define (prime-sum a b)
    (filtered-accumulate + 0 prime? identity a inc b)
)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;求所有小于n、与n互素的正整数之乘积
(define (inter-prime-product n)
    (define (inter-prime? i)
        (= (gcd i n) 1))
    (filtered-accumulate * 1 inter-prime? identity 1 inc (- n 1))
)