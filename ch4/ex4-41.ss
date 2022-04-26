#lang sicp
; 累加器
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
;;;;;;;;

;过滤器
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
;;;;;;;;;

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

; (define (unique-pairs1 n)
;     (accumulate append
;                 nil
;                 (map (lambda (i)
;                              (map (lambda (j) (list i j))
;                                   (enumerate-interval 1 (- i 1))))
;                      (enumerate-interval 1 n))) 
; )

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (constraint pair)
    (and (> (list-ref pair 3) (list-ref pair 1))
         (not (= (abs (- (list-ref pair 4) (list-ref pair 2))) 1))
         (not (= (abs (- (list-ref pair 2) (list-ref pair 1))) 1))
         (distinct? pair)))


(define solve-floor-problem
    (filter constraint
            (flatmap (lambda (first-four)
                             (map (lambda (smith)
                                          (append first-four (list smith)))
                                  (enumerate-interval 1 5)))
                     (flatmap (lambda (first-three)
                                      (map (lambda (miller)
                                                   (append first-three (list miller)))
                                           (enumerate-interval 1 5)))
                              (flatmap (lambda (first-two)
                                               (map (lambda (fletcher)
                                                            (append first-two (list fletcher)))
                                                    (enumerate-interval 2 4)))
                                       (flatmap (lambda (baker)
                                                        (map (lambda (cooper)
                                                                     (list baker cooper))
                                                             (enumerate-interval 2 5)))
                                                (enumerate-interval 1 4)))))))

solve-floor-problem