#lang sicp
(define (element-of-set? x items)
    (cond ((null? items) #f)
          ((eq? x (car items)) #t)
          (else (element-of-set? x (cdr items))))
)

(define (count-pairs x)
    (let ((visited '()))
        (define (iter-base x)
            (cond ((not (pair? x)) 0)
                  ;;; 注意，这样写不对！
                  ;;;((element-of-set? x visited) (+ (count-pairs (car x)) (count-pairs (cdr x))))  
                  ((element-of-set? x visited) 0)
                  (else (set! visited (cons x visited))
                        (+ (iter-base (car x)) (iter-base (cdr x)) 1))))
        (iter-base x))
)

(define z1 (list 'a 'b 'c))
(count-pairs z1)   

(define x2 (cons 'a 'b))
(define z2 (cons 'c (cons x2 x2)))
(count-pairs z2)   

(define x3 (cons 'a 'b))
(define y3 (cons x3 x3))
(define z3 (cons y3 y3))
(count-pairs z3)   

(define z4 (list 'a 'b 'c))
(set-cdr! (cddr z4) z4)
(count-pairs z4)  ; 无限循环