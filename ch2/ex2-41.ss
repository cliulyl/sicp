#lang sicp
;;;;;;; libs
(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

; 累加器
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;过滤器
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;对集合做排列
(define (permutations s)
  (if (null? s)                         ; empty set?
      (list nil)                        ; sequence containing empty set
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))
;;;;;;;;

(define (find-triplet n s)
    (define (check-triplet-sum seq)
        (= s
        (+ (car seq)
            (cadr seq)
            (caddr seq))))
    (flatmap permutations
             (filter check-triplet-sum
                     (generate-triplet n)))
)



(define (generate-doublet n)
    (flatmap (lambda (i)
                     (map (lambda (j) (list j i))
                          (enumerate-interval 1 (- i 1))))
              (enumerate-interval 1 n))
)

(define (generate-triplet n)
    (flatmap (lambda (item)
                     (map (lambda (k) (cons k item))
                          (enumerate-interval 1 (- (car item) 1))))
             (generate-doublet n))
)
