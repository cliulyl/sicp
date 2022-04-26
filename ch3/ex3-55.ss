#lang racket
(require "stream.scm")
(require "infinite_stream.scm")

(define (partial-sums-old S)
    (cons-stream (stream-car S)
                 (add-streams (partial-sums-old S)
                             (stream-cdr S))))

(define (partial-sums S)  ; 这是一个重要的优化：利用ret流的记忆避免重复运算，如果像上面partial-sums-old一样，调用partial-sums-old S时重启动一个计算过程，不会有记忆效果
    (define ret
        (cons-stream (stream-car S)
                     (add-streams ret
                                  (stream-cdr S))))
    ret)

(define psi (partial-sums integers))