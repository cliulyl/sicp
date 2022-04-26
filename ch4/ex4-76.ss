#lang sicp
(define (new-conjoin conjuncts frame-stream)
    (if (empty-conjunction? conjuncts)
        frame-stream
        (combine-streams (qeval (first-conjunct conjuncts)
                                frame-stream)
                         (new-conjoin (rest-conjuncts conjuncts) frame-stream))))
                    
(define (combine-streams stream1 stream2)
    (stream-flatmap
      (lambda (frame-in-2)
          (stream-filter
              (lambda (f) (not (eq? f 'failed)))
              (stream-map
                (lambda (frame-in-1)
                        (merge-frames frame-in-1 frame-in-2))
                stream1)))
      stream2))

(define (merge-frames frame1 frame2)
    (if (null? frame1)
        frame2
        (let ((var (binding-variable (car frame1)))
              (val (binding-value (car frame1))))
             (merge-frames (cdr frame1)
                           (extend-if-possible var val frame2)))))