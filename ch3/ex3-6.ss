#lang racket
(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

(define random-init 7)			;**not in book**
(define rand
  (let ((x random-init))
    (lambda (input)
      (cond ((eq? input 'generate) (set! x (rand-update x)) x)
            ((eq? input 'reset) (lambda (new-value) (set! x new-value))))))
)

; 注意下面的写法不可以！每次出来的不是随机值，而是同样的值
; (define (rand input) 
;   (let ((x random-init))
;     (cond ((eq? input 'generate) (set! x (rand-update x)) x)
;           ((eq? input 'reset) (lambda (new-value) (set! x new-value)))))
; )
