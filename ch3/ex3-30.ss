#lang sicp
; (full-adder a b c-in sum c-out)

(define (ripple-carry-adder A B S C)
    (define (iter-base a-remain b-remain s-remain c-in c-out)
        (if (null? (cdr a-remain))
            (full-adder (car a-remain) (car b-remain) c-in (car s-remain) c-out)
            (let ((wire (makewire)))
                (iter-base (cdr a-remain) (cdr b-remain) (cdr s-remain) c-in wire)
                (full-adder (car a-remain) (car b-remain) wire (car s-remain) c-out))))
    (let ((c-in (makewire)))
        (set-singal! c-in 0)
        (iter-base A B S c-in C))
)