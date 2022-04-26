#lang sicp
(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))

        (define (set-front-ptr! item)
            (set! front-ptr item)) 

        (define (set-rear-ptr! item)
            (set! rear-ptr item))

        (define (empty-queue?)
            (null? front-ptr))

        (define (front-queue)
            (if (empty-queue?)
                (error "FRONT called with an empty queue")
                (car front-ptr)))
        
        (define (print-queue)
            (display front-ptr)
            (newline))

        (define (insert-queue! item)
            (let ((new-pair (cons item '())))
                (cond ((empty-queue?)
                    (set-front-ptr! new-pair)
                    (set-rear-ptr! new-pair)
                    dispatch)   ;; 注意：这里返回过程自己，应该是dispatch
                    (else
                    (set-cdr! rear-ptr new-pair)
                    (set-rear-ptr! new-pair)
                    dispatch)))) 
        
        (define (delete-queue!)
            (cond ((empty-queue?)
                   (error "DELETE! called with an empty queue"))
                  (else
                    (set-front-ptr! (cdr front-ptr))
                    dispatch))) 

        (define (dispatch m)
            (cond ((eq? m 'front-ptr) front-ptr)
                  ((eq? m 'rear-ptr) rear-ptr)
                  ((eq? m 'empty-queue?) empty-queue?)
                  ((eq? m 'front-queue?) front-queue)
                  ((eq? m 'insert-queue!) insert-queue!)
                  ((eq? m 'delete-queue!) delete-queue!)
                  ((eq? m 'print-queue) print-queue)))
        dispatch)
)

(define (empty-queue? queue) ((queue 'empty-queue?)))  ;;注意这里的定义，需要再加一层括号，以便执行返回的过程
(define (front-queue queue) ((queue 'front-queue)))
(define (insert-queue! queue item) ((queue 'insert-queue!) item))
(define (delete-queue! queue) ((queue 'delete-queue!)))
(define (print-queue queue) ((queue 'print-queue)))

(define q1 (make-queue))
(insert-queue! q1 'a)
(print-queue q1)
(insert-queue! q1 'b)
(print-queue q1)
(delete-queue! q1)
(print-queue q1)
(delete-queue! q1)
(print-queue q1)