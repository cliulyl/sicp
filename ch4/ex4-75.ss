#lang sicp

(define (uniquely-asserted operands frame-stream)
    (define (only-one? stre)     
    ;注意这里对“流里只有一个元素的判断”：不能使用长度；需要用stream-开头的判断
        (and (not (stream-null? stre))
             (stream-null? (stream-cdr stre))))
    (stream-flatmap
        (lambda (frame)
            (let ((extend-frame-stream (qeval (car operands)
                                              (singleton-stream frame))))
                 (if (only-one? extend-frame-stream)
                     extend-frame-stream
                     the-empty-stream)))
        frame-stream))

(put 'unique 'qeval uniquely-asserted)


;; query:
(and (supervisor ?x ?boss)
     (unique (supervisor ?anyone ?boss)))