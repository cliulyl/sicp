#lang racket
(require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

;;;;;; libs

;;;;;;
(define (split op-big op-small)
    (lambda (painter n)
            (if (= n 0)
                painter
                (let ((smaller ((split op-big op-small) painter (- n 1))))
                     (op-big painter (op-small smaller smaller)))))

)

(define right-split (split beside below))

(define up-split (split below beside))

(define (corner-split painter n)
    (if (= n 0)
        painter
        (let ((up (up-split painter (- n 1)))
              (right (right-split painter (- n 1))))
            (let ((top-left (beside up up))
                (bottom-right (below right right))
                (corner (corner-split painter (- n 1))))
            (beside (below painter top-left)
                    (below bottom-right corner))))))

(paint (corner-split einstein 4))